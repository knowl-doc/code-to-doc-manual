FROM public.ecr.aws/t7d0n7r6/knowl-code-to-doc-manual:latest
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]