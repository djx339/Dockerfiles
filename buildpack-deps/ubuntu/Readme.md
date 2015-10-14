You need add below when using `buildpack-deps:ubuntu-14.04-sshd`

```bash
RUN COPY id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys
```
