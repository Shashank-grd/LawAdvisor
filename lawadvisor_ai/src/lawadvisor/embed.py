from dotenv import load_dotenv
import os
from langchain_google_genai import GoogleGenerativeAIEmbeddings
from pinecone import Pinecone
from langchain_pinecone import PineconeVectorStore
from src.lawadvisor.utils import text_chunk

load_dotenv()
GOOGLE_API_KEY=os.getenv('GOOGLE_API_KEY')
PINECONE_API_KEY=os.getenv('PINECONE_API_KEY')

os.environ["PINECONE_API_KEY"] = PINECONE_API_KEY
os.environ["GOOGLE_API_KEY"] = GOOGLE_API_KEY

embeddings = GoogleGenerativeAIEmbeddings(
    model="models/embedding-001", task_type="retrieval_query"
)


pc = Pinecone(api_key=PINECONE_API_KEY)

index_name="lawbot"

index=pc.Index("lawbot")

vectorstore=PineconeVectorStore(embedding=embeddings, index_name=index_name,pinecone_api_key=PINECONE_API_KEY)

#vectorstore.add_texts([t.page_content for t in text_chunk])