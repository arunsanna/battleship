FROM docker.io/arunsanna/ubi-8-standard:latest as build

FROM registry.access.redhat.com/ubi8/ubi-micro:8.5

COPY scripts /dsop-fix/

# COPY yum.repos.d/ /etc/yum.repos.d
# COPY banner/issue /etc/

RUN echo Update packages and install DISA STIG fixes
# Disable all repositories (to limit RHEL host repositories) and only use official UBI repositories
# rm -f /etc/yum.repos.d/ubi.repo && \
# Do not use loops to iterate through shell scripts, this allows for scripts to fail
# but the build to still be successful. Be explicit when executing scripts and ensure
# that all scripts have "set -e" at the top of the bash file!
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_openssl_use_strong_entropy.sh
RUN rm -rf /dsop-fix/ /var/cache/dnf/ /var/tmp/* /tmp/* /var/tmp/.???* /tmp/.???*

# for umask, remediation scripts fails since grep/sed are missing
COPY --from=build --chown=0:0 /etc/bashrc /etc/bashrc

ENV container oci
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

CMD ["/bin/bash"]
