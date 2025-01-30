from langchain_community.document_loaders import PyPDFLoader, DirectoryLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter



def loadPdf(data):
  loader =   DirectoryLoader(data,glob="*.pdf",loader_cls=PyPDFLoader)

  documents = loader.load()
  return documents

extracted_data = loadPdf(r"C:\Users\SHASHANK\StudioProjects\lawadvisor\lawadvisor_ai\data")

def text_split(extracted_data):
    text_splitter = RecursiveCharacterTextSplitter(chunk_size = 1000,chunk_overlap=50)
    text_chunk = text_splitter.split_documents(extracted_data)

    return text_chunk

text_chunk = text_split(extracted_data)
print(len(text_chunk))