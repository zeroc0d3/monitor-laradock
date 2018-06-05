ARG GRAFANA_VERSION=5.1.3
FROM grafana/grafana:${GRAFANA_VERSION}

# ================================================================================================
#  Inspiration: Docker Framework (https://github.com/zeroc0d3/docker-framework)
#               Dwi Fahni Denni <zeroc0d3.0912@gmail.com>
# ================================================================================================
#  Core Contributors:
#   - Mahmoud Zalt @mahmoudz
#   - Bo-Yi Wu @appleboy
#   - Philippe Trépanier @philtrep
#   - Mike Erickson @mikeerickson
#   - Dwi Fahni Denni @zeroc0d3
#   - Thor Erik @thorerik
#   - Winfried van Loon @winfried-van-loon
#   - TJ Miller @sixlive
#   - Yu-Lung Shao (Allen) @bestlong
#   - Milan Urukalo @urukalo
#   - Vince Chu @vwchu
#   - Huadong Zuo @zuohuadong
# ================================================================================================

MAINTAINER "Laradock Team <mahmoud@zalt.me>"

# ENV GF_SERVER_ROOT_URL="http://localhost:3000"
ENV GF_SECURITY_ADMIN_USER="laradock" \
    GF_SECURITY_ADMIN_PASSWORD="password" \
    GF_INSTALL_PLUGINS="alexanderzobnin-zabbix-app,cloudflare-app,crate-datasource,digiapulssi-breadcrumb-panel,grafana-azure-monitor-datasource,grafana-clock-panel,grafana-simple-json-datasource,grafana-kubernetes-app,grafana-worldmap-panel,percona-percona-app,raintank-worldping-app"

# AWS Credential for CloudWatch Support:
# ENV GF_AWS_PROFILES="default" \
#     GF_AWS_default_ACCESS_KEY_ID="YOUR_ACCESS_KEY" \
#     GF_AWS_default_SECRET_ACCESS_KEY="YOUR_SECRET_KEY" \
#     GF_AWS_default_REGION="us-east-1"

EXPOSE 3000
CMD []