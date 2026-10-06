# Scripts Linux — Infraestrutura como Código

Scripts Bash que automatizam a configuração de usuários, grupos e permissões em um servidor Linux. Projeto desenvolvido no curso de Linux da DIO.

## Scripts

| Script | O que faz |
|---|---|
| `iac1.sh` | Cria os diretórios `/publico`, `/adm`, `/ven` e `/sec`, os grupos `GRP_ADM`, `GRP_VEN` e `GRP_SEC`, nove usuários distribuídos entre eles e aplica as permissões (cada departamento só acessa a própria pasta; `/publico` é aberta a todos). |
| `criar_user.sh` | Cria os usuários convidados `guest10` a `guest13`. |

Em ambos, a senha inicial expira no primeiro login, obrigando o usuário a trocá-la. Os scripts podem ser executados mais de uma vez sem erro: diretórios, grupos e usuários que já existem são mantidos.

## Como usar

Testado para distribuições baseadas em Debian/Ubuntu. Use uma máquina virtual ou servidor de testes.

```bash
chmod +x iac1.sh criar_user.sh
sudo ./iac1.sh
```

A senha inicial padrão é `Senha123`. Para definir outra:

```bash
sudo SENHA='OutraSenha' ./iac1.sh
```
