FROM public.ecr.aws/lambda/python:3.11

# Copy requirements and install dependencies
COPY requirements.txt ${LAMBDA_TASK_ROOT}
RUN pip install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"

# Copy application code
COPY . ${LAMBDA_TASK_ROOT}

# Set the CMD to your handler
CMD ["app.handler"]
