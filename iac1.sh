#!/bin/bash
# Infraestrutura como código: cria diretórios, grupos e usuários
# com as permissões de cada departamento.
# Uso: sudo ./iac1.sh   (senha inicial opcional: sudo SENHA=MinhaSenha ./iac1.sh)
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "Execute como root (sudo ./iac1.sh)" >&2
  exit 1
fi

SENHA="${SENHA:-Senha123}"
HASH=$(openssl passwd -6 "$SENHA")

criar_usuario() {
  local usuario=$1 grupo=$2
  if id "$usuario" &>/dev/null; then
    echo "  $usuario já existe, pulando"
  else
    useradd "$usuario" -m -s /bin/bash -p "$HASH" -G "$grupo"
    passwd -e "$usuario" >/dev/null   # obriga a trocar a senha no primeiro login
    echo "  $usuario criado ($grupo)"
  fi
}

echo "Criando diretórios..."
mkdir -p /publico /adm /ven /sec

echo "Criando grupos de usuários..."
for grupo in GRP_ADM GRP_VEN GRP_SEC; do
  groupadd -f "$grupo"
done

echo "Criando usuários..."
for u in carlos maria joao;          do criar_usuario "$u" GRP_ADM; done
for u in debora sebastiana roberto;  do criar_usuario "$u" GRP_VEN; done
for u in josefina amanda rogerio;    do criar_usuario "$u" GRP_SEC; done

echo "Especificando permissões dos diretórios..."
chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec

chmod 770 /adm /ven /sec
chmod 777 /publico

echo "Fim."
