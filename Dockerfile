FROM texlive/texlive:latest

# Install Ruby and dependencies
RUN apt-get update && apt-get install -y \
    ruby \
    ruby-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install bibtex-ruby gem
RUN gem install bibtex-ruby

# Set working directory
WORKDIR /data

# Default command: watch and build
# We'll use a script to run the prettifier and then latexmk
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
