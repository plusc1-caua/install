#!/bin/bash
barra="\033[0m\e[34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
[[ ! -e /bin/ipw ]] && echo "/root/Panelweb.sh" > /bin/ipw && chmod +x /bin/ipw #ACCESO RAPIDO
fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} > /dev/null 2>&1
${comando[1]} > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}
IP=$(cat /etc/IP)
x="ok"
menu ()
{
#PAINEL A INSTALAR
panel_c1 () {
wget https://raw.githubusercontent.com/plusc1-caua/install/main/Panel_Web/panel_v25/install > /dev/null 2>&1; chmod +x Painel.sh; ./Painel.sh
}
#PANIL REMOVE
remove_panel () {
clear
echo ""
echo -e "\033[1;36mDESINTALAR PANEL WEB"
echo ""
echo -ne "\033[1;37mDesinstalar MySQL [N/S]: \033[1;37m"; read x
[[ $x = @(n|N) ]] && exit
##sudo 
apt-get purge mysql-server mysql-client mysql-common mysql-server-core-* mysql-client-core-*
rm -rf /etc/mysql /var/lib/mysql
apt-get autoremove
apt-get autoclean
service apache2 restart
echo ""
echo -e "\033[1;36mPANEL ELIMINADO COM SUCESSO -\033[1;32m OK !\033[1;37m"
echo ""
sleep 4s
chmod +x Panelweb.sh; ./Panelweb.sh
}
#OPCIONES DE SISTEMA
atualizar () {
echo ""
fun_bar "apt-get update -y"
fun_bar "apt-get upgrade -y"
fun_att () {
    service ssh restart > /dev/null 2>&1
    rm -rf $HOME/Panelweb.sh* > /dev/null 2>&1
    wget https://raw.githubusercontent.com/plusc1-caua/install/main/Panel_Web/Panelweb.sh > /dev/null 2>&1
}
fun_bar 'fun_att'
echo ""
echo -e "\033[1;33m UPDATE COM SUCESSO -\033[1;32m OK !\033[1;37m"
sleep 4s
chmod +x Panelweb.sh; ./Panelweb.sh
}
remove_multiscripts () {
rm -rf $HOME/Panelweb.sh* && rm -rf /bin/ipw
}

while true $x != "ok"
do
_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
_usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
clear
echo -e "$barra"
echo -e "\E[41;1;37m       INSTALAR PAINEL SSH       \033[1;32m[\033[1;37m  VERSAO: r002 \033[1;32m]\E[0m"
echo -e "$barra"
echo ""
echo -e "\033[1;31m[\033[1;36m01\033[1;31m] \033[1;37m• \033[1;33mPAINEL C1 PLUS       \033[1;31m"
echo -e "\033[1;31m[\033[1;36m02\033[1;31m] \033[1;37m• \033[1;33mREMOVE MYSQL                \033[1;36m\033[1;31m"
echo -e "\033[1;31m[\033[1;36m03\033[1;31m] \033[1;35m[!] \033[1;32mATUALIZAR \033[1;35m\033[1;37m \033[1;35m       \033[1;31mRam:\033[1;37m $_usor "
echo -e "\033[1;31m[\033[1;36m04\033[1;31m] \033[1;35m[!] \033[1;31mLIMPAR CACHE \033[1;35m\033[1;37m \033[1;35m       \033[1;31mNucleo:\033[1;37m $_usop "
echo -e "\033[1;31m[\033[1;36m00\033[1;31m] \033[1;37mSALIR \033[1;32m<\033[1;33m<\033[1;31m< \033[0m"
echo -e "\033[1;37m@Universe_say\033[0m \033[0m"
echo -e "$barra"
echo ""
echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;31m?\033[1;37m : "; read x

case "$x" in 
1 | 01)
clear
panel_c1
exit;
;;
2 | 02)
clear
remove_panel
exit;
;;
3 | 03)
clear
atualizar
exit;
;;
4 | 04)
clear
remove_multiscripts
exit;
;;
0 | 00)
echo -e "\033[1;31mSaindo...\033[0m"
sleep 2
clear
exit;
;;
*)
echo -e "\n\033[1;31mOpcao invalida !\033[0m"
esac
done
}
menu
#fim