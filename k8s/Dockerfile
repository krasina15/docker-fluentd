FROM fluent/fluentd:v1.16-debian-1

# Switch to root to install plugins
USER root

# Install plugins
RUN gem install \
    fluent-plugin-elasticsearch:5.3.0 \
    fluent-plugin-kubernetes_metadata:3.2.0 \
    fluent-plugin-prometheus:2.1.0 \
    --no-document

# Create directories
RUN mkdir -p /var/log/fluentd-buffers /var/log/containers /var/log/pods

# Copy configuration
COPY fluent.conf /fluentd/etc/fluent.conf

# Switch back to fluent user
USER fluent

# Expose metrics port
EXPOSE 24231