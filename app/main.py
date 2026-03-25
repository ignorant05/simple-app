from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "This is the main endpoint."}


@app.get("/health")
async def heath():
    return {"message": "All good!"}
