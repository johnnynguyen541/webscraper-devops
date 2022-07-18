FROM python:3.8.9

# Create a working directory
WORKDIR /scrape-bot

# Copy source code to working directory
COPY . /scrape-bot

# Install packages from requirements.txt
# hadolint ignore=DL3013,DL3042
RUN pip install --upgrade pip &&\
	pip install --trusted-host pypi.python.org -r requirements.txt

# Expose port 5002
EXPOSE 5002

# Run app.py at container launch
CMD ["python","app/app.py"]
