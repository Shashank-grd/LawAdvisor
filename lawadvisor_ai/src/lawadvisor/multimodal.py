from src.lawadvisor.embed import vectorstore,GOOGLE_API_KEY,PINECONE_API_KEY
from langchain.chains import RetrievalQA
from langchain.prompts import PromptTemplate
from langchain_google_genai import ChatGoogleGenerativeAI
import google.generativeai as genai
from langchain.chains.question_answering import load_qa_chain

genai.configure(api_key=GOOGLE_API_KEY)
model = ChatGoogleGenerativeAI(model="gemini-pro",temperature=0.3)


prompt_template="""
You are a legal assistant designed to help you navigate complex legal matters. Please provide detailed information about your legal issue.
Use the following pieces of information to answer the user's question.
If you don't know the answer, just say that you don't know, don't try to make up an answer give answer in the domain of law only.

Context: {context}
Question: {question}
"""

PROMPT=PromptTemplate(template=prompt_template, input_variables=["context", "question"])
chain=load_qa_chain(model, chain_type="stuff", prompt=PROMPT)

def user_input(user_question,chain):
    docs =  vectorstore.similarity_search(user_question, k=4)

    chain = chain


    response = chain.invoke(
        {"input_documents":docs, "question": user_question},
        return_only_outputs=True
        )

    return response