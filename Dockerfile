# Stage 1: Build frontend
FROM node:22-alpine AS frontend
WORKDIR /app/frontend
COPY frontend/package.json frontend/package-lock.json ./
RUN npm ci
COPY frontend/ .
ENV NEXT_OUTPUT_DIR=out
RUN npm run build

# Stage 2: Production runtime
FROM python:3.12-slim
WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY server.py agent.py worker.py storage.py ./
COPY .env.example ./

COPY --from=frontend /app/frontend/out ./static

EXPOSE 8500
ENV PORT=8500

CMD ["python", "server.py"]
