# Utilize the image from download.yaml
# This is because we need to download the latest image from Red Hat. Current
# implementation for doing ARG based FROM instructions require replacing
# the FROM with an already existing image (i.e. one we've previously built).
# This prevents us from retrieving the latest image from Red Hat.
FROM registry.access.redhat.com/ubi8/ubi-minimal:8.5


COPY scripts /dsop-fix/

#COPY yum.repos.d/ /etc/yum.repos.d

#COPY banner/issue /etc/

# Be careful when adding packages because this will ultimately be built on a licensed RHEL host,
# which enables full RHEL repositories and could allow for installation of packages that would
# violate Red Hat license agreement when running the container on a non-RHEL licensed host.
# See the following link for more details:
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/building_running_and_managing_containers/index/#add_software_to_a_running_ubi_container

RUN echo "[main]" >> /etc/dnf/dnf.conf
RUN echo "exclude=filesystem-*" >> /etc/dnf/dnf.conf
RUN echo Update packages and install DISA STIG fixes

# Disable all repositories (to limit RHEL host repositories) and only use official UBI repositories
# rm -f /etc/yum.repos.d/ubi.repo && \

RUN microdnf repolist
RUN microdnf update
RUN microdnf install -y crypto-policies-scripts

# Do not use loops to iterate through shell scripts, this allows for scripts to fail
# but the build to still be successful. Be explicit when executing scripts and ensure
# that all scripts have "set -e" at the top of the bash file!
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_configure_crypto_policy.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_openssl_use_strong_entropy.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_configure_openssl_crypto_policy.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_umask_etc_bashrc.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_umask_etc_profile.sh
RUN /dsop-fix/xccdf_org.ssgproject.content_rule_accounts_umask_etc_csh_cshrc.sh
RUN microdnf clean all
RUN rm -rf /dsop-fix/ /var/cache/dnf/ /var/tmp/* /tmp/* /var/tmp/.???* /tmp/.???*

ENV container oci
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

CMD ["/bin/bash"]
