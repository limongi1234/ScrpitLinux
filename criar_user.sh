#!/bin/bash
# Cria usuários convidados (guest10 a guest13) com senha que expira no primeiro login.
# Uso: sudo ./criar_user.sh   (senha inicial opcional: sudo SENHA=MinhaSenha ./criar_user.sh)
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "Execute como root (sudo ./criar_user.sh)" >&2
  exit 1
fi

SENHA="${SENHA:-Senha123}"
HASH=$(openssl passwd -6 "$SENHA")

echo "Criando usuários do sistema..."

for usuario in guest10 guest11 guest12 guest13; do
  if id "$usuario" &>/dev/null; then
    echo "  $usuario já existe, pulando"
    continue
  fi
  useradd "$usuario" -c "Usuário convidado" -s /bin/bash -m -p "$HASH"
  passwd -e "$usuario" >/dev/null
  echo "  $usuario criado"
done

echo "Finalizado!"
