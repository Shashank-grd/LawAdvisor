from fastapi import FastAPI, File, UploadFile, Form
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
from dotenv import load_dotenv
from src.lawadvisor.logger import logging
import os
import google.generativeai as genai
from PIL import Image
from io import BytesIO
from src.lawadvisor.multimodal import chain,user_input


load_dotenv()
GOOGLE_API_KEY=os.getenv('GOOGLE_API_KEY')
os.environ["GOOGLE_API_KEY"] = GOOGLE_API_KEY



app = FastAPI()


app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  
    allow_credentials=True,
    allow_methods=["*"],  
    allow_headers=["*"], 
)


genai.configure(api_key=GOOGLE_API_KEY)
model = genai.GenerativeModel('gemini-1.5-flash')
def get_gemini_response(image):
    input_prompt = """
            Analyze the provided image and generate a detailed description of its
            content, focusing on aspects that might be relevant to legal contexts. 
            Include any visible text, identifiable objects, actions, and settings
            that could pertain to issues such as compliance, disputes, safety,
            intellectual property, or rights violations. Ensure the description 
            is clear, precise, and formatted in a manner suitable for legal documentation
"""
    response = model.generate_content([input_prompt, image])
    return response.text

@app.post("/api/process_query/")
async def process_query(query: str = Form(...), file: UploadFile = File(None)):
    logging.info("Api hitting")
    """
    Process the user query and image (if provided) and return a response.
    """
    if file:
        # Read image file bytes
        image_bytes = await file.read()
        image = Image.open(BytesIO(image_bytes))  # Open the image from bytes
            
        # Generate image description using Generative AI
        input_image_summary = get_gemini_response(image)
        response = user_input(
            input_image_summary + "based on this description. " + query , chain
        )
    else:
        # If no file, just process the query
        response=user_input(query,chain)
    return JSONResponse(content={"response": response['output_text']})

@app.get("/")
def read_root():
    return {"message": "Welcome to the Multimodal Retrieval API"}