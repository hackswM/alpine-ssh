FROM alpine:latest

ENV Env_System_RootPassword="Gv4acbsE5Tm" \
    Env_System_Timezone="Asia/Shanghai"

COPY source/entrypoint.sh /usr/sbin/entrypoint.sh

# 系统核心组件升级
RUN ( apk --no-cache upgrade ;\
      apk --no-cache add openssh-server ;\
      sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config ;\
      echo "root:${Env_System_RootPassword}" | chpasswd ;\
      apk --no-cache add tzdata ;\
      echo "${Env_System_Timezone}" > /etc/timezone ;\
      ln -sf /usr/share/zoneinfo/${SYS_TIMEZONE} /etc/localtime ;\
      chmod +x /usr/sbin/entrypoint.sh ;\
      rm -rf /var/cache/apk/* /tmp/* )

# 默认开放端口 22
EXPOSE 22

# 启动命令行
CMD [ "sh", "/usr/sbin/entrypoint.sh" ]
