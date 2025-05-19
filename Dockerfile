FROM fluent/fluentd:v1.16-1

# Switch to root to install plugins
USER root

# Install elasticsearch plugin
RUN gem install fluent-plugin-elasticsearch --no-document --version 5.3.0

# Create directories
RUN mkdir -p /var/log/td-agent && \
    chown -R fluent:fluent /var/log/td-agent

# Switch back to fluent user
USER fluent

# Copy configuration file
COPY fluent.conf /fluentd/etc/fluent.conf

# Expose Fluentd monitoring port
EXPOSE 24220

# Run Fluentd
CMD ["fluentd", "-c", "/fluentd/etc/fluent.conf"]