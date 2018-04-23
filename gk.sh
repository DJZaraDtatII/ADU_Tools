#!/bin/bash

#------------------------------------------------------------------------------------------------------
# Credit to: xpirt for sdat2img.py - dan semua yang berkontribusi 
#------------------------------------------------------------------------------------------------------
# Provided by: rendiix

me="\e[38;5;196m"
hi="\e[38;5;82m"
ku="\e[38;5;226m"
bi="\e[38;5;21m"
mag="\e[38;5;14m"
bpu="\e[48;5;15m"
tbl="\e[1m"
dim="\e[2m"
no="\e[0m"
bnr() {
banner="${tbl}${mag}
==================================================
=${tbl}${bpu}${bi}             Android DAT Unpacker               ${no}${tbl}${mag}=
=${tbl}${bpu}${bi}                  by gk-dev                     ${no}${tbl}${mag}=
==================================================${no}"
echo -e "$banner"
}
brs() {
    echo -e ""
	echo -e "${tbl}${mag}==================================================${no}"
	echo -e ""
}
info() {
info="${tbl}${ku}
Device info ${no}
${tbl}
  Model          : $(getprop ro.product.manufacturer)-$(getprop ro.product.model) ($(getprop ro.product.name))
  Versi Android  : $(getprop ro.build.version.release)
  Versi OS       : $(getprop ro.build.version.incremental)
  Memori tersisa : $mem ${no}"
echo -e "$info"
}
jda() {
brs;
read -s -n 1 -p "Kembali ke menu utama..."
}
txtinfo() {
csooninfo="

${hi}  Fiture akan segera ditambahkan,
dev lagi bertapa nyari materi.

Bagi yang ingin ikut berkontribusi silahkan
kontak saya di:
 
 • Email   : vanzdobz@gmail.com
 • Phone   : +62812 2514 5xxx
 • Fb      : -
 • Discord : -${no}"
echo -e "$csooninfo"
}
csoon() {
cl;
bnr;
info;
brs;
echo -e "${tbl}${ku}Info:${no}"
txtinfo;
jda;
main;
}
repackalrt() {
cl;
bnr;
info;
brs;
repackinfo="${tbl}${ku}Info:${no}

${me}  Fiture untuk sementara dinonaktifkan!

Permasalahan cross compile binary ${bi}make_ext4fs${no}
${me}yang belum support untuk Android.${no}"

echo -e "$repackinfo"
txtinfo;
jda;
main;
}
winput() {
brs;
echo -e "${me}${tbl}Masukan salah, coba lagi${no}";
jda;
main;
}
memwarn() {
cl;
bnr;
info;
brs;
echo -e "${me}${tbl}Penyimpanan tidak cukup, pastikan ruang kosong lebih dari 5 GB${no}";
jda;
main;
}
miss() {
cl;
bnr;
info;
brs;
missinfo="${me}File yg dibutuhkan tidak lengkap...${no}

${ku}Pastikan sudah memasukkan file:${no}
${tbl}system.new.dat${no} ${ku}dan${no} ${tbl}system.transfer.list${no}
${ku}kedalam folder:${no} ${tbl}$target${no}"
echo -e "$missinfo"
jda;
main;
}
udone() {
cl;
bnr;
info;
brs;
echo -e "${hi}Proses selesai...${no}";
txtinfo;
jda;
main;
}
quit() {
exit
}
cl() {
clear
echo ""
}
unpack() {
if [ "$mem2" -lt "5800000" ]; then
memwarn;
else
unpackmain;
fi
}
ubuntu_done() {
cl;
bnr;
info;
brs;
ubuntud="${hi}Instalasi ubuntu selesai...
Anda dapat memulai Ubuntu dari start screen
atau dengan mengetikkan perintah ${mag}startubuntu${no}
${ku}
Silahkan restart termux${no}"
echo -e "$ubuntud"
jda;
main;
}
installubuntu() {
cl;
bnr;
info;
brs;
cd ~/
echo -e "${ku}Cloning repositories...${no}$mag"
git clone https://github.com/rendiix/ubuntu-chroot.git
echo -e "${ku}Memasang ubuntu...${no}$mag"
cd ~/ubuntu-chroot
chmod +x ubuntu.sh
exec ubuntu.sh
cd $root
termuxstart;
}
termuxstart() {
prof=/data/data/com.termux/files/usr/etc/profile
motd=/data/data/com.termux/files/usr/etc/motd
cl;
bnr;
info;
brs;
echo -e "${ku}Menambahkan Termux start screen...$no"
brs;
echo -e "${ku}Masukkan nama anda...

contoh nama: gk-dev
akan tampil di start seperti ini:${no}${hi}"
figlet gk-dev
brs;
read -p "Nama: " nama
cat > $motd <<- EOM
EOM
cat > $prof <<- 'EOM'
for i in /data/data/com.termux/files/usr/etc/profile.d/*.sh; do
	if [ -r $i ]; then
		. $i
	fi
done
unset i

# Source etc/bash.bashrc and ~/.bashrc also for interactive bash login shells:
if [ "$BASH" ]; then
        if [[ "$-" == *"i"* ]]; then
                if [ -r /data/data/com.termux/files/usr/etc/bash.bashrc ]; then
                        . /data/data/com.termux/files/usr/etc/bash.bashrc
                fi
                if [ -r /data/data/com.termux/files/home/.bashrc ]; then
                        . /data/data/com.termux/files/home/.bashrc
                fi
        fi
fi
me="\e[38;5;196m"
hi="\e[38;5;82m"
ku="\e[38;5;226m"
bi="\e[38;5;21m"
mag="\e[38;5;14m"
tbl="\e[1m"
dim="\e[2m"
no="\e[0m"
tgl="$(date)"
logo="$(figlet ganti_nama)"
ubuntu() {
clear
echo -e "${tbl}${hi}Welcome to Ubuntu!";
echo -e "";
echo -e "$logo"
echo -e "$no"
echo -e "${mag}$tgl${no}"
echo -e "${hi}----------------------------${no}";
echo -e ""
startubuntu
}
termux() {
clear
echo -e "${tbl}${hi}Welcome to termux!";
echo -e "";
echo -e "$logo"
echo -e "$no"
echo -e "${mag}$tgl${no}"
echo -e "${hi}----------------------------${no}";
echo -e ""
fish
}
salah() {
start;
}

start() {
clear
echo -e "${tbl}${hi}Welcome to Termux start screen";
echo -e "";
echo -e "$logo"
echo -e "$no"
echo -e "${mag}$tgl${no}";
echo -e "${hi}----------------------------${no}";
echo -e ""
echo -e "${tbl}${ku}Silahkan pilih system:${no}"
echo -e "${tbl}${mag}";
echo -e "  1. Ubuntu   2. Termux";
echo -e "${no}";
read env;
case $env in
 1|1) ubuntu;;
 2|2) termux;;
 *) salah;;
esac
}
start;
EOM
sed -i "s/ganti_nama/$nama/g" $prof
ubuntu_done;
}
unpackmain() {
if [[ -e $sdat && -e $tfrl ]]; then
    cl;
    bnr;
    info;
    brs;
    echo -e  "${ku}Covert DAT ke RAW.img...${no}";
    brs;
    $d2img $tfrl $sdat $target/system.img 2>/dev/null >> $logs/unpack_log.txt
    cl;
bnr;
info;
brs;
echo -e "${ku}${tbl}Extract RAW.img ke foleder system...${no}";
echo -e "$mag"
if [ -d $target/system ]; then
rm -r $target/system
else
mkdir $target/system
7z x -o$target/system/ $target/system.img
fi
echo -e "$no"
echo -e "${hi}Unpack selesai...${no}";
rm $target/system.img
jda;
main;
else
    miss;
fi
}
repack() {
if [[ -e $fosys && -e $cntx ]]; then
    cl;
    bnr;
    info;
    brs;
    echo -e  "${ku}Sedang memproses...${no}";
    brs;
    read -p "Masukkan ukuran system (bit): " ukuran
    $mext -T -0 -S $cntx -l ${ukuran} -a system $target/raw.img $target/system/  >>$logs/repack_log.txt
    $img2s $target/raw.img $target/sparse.img 4096 >>$logs/repack_log.txt
    rm -r $target/raw.img
    if [ -d "$target/output/" ]; then
        rm -r $target/output
        mkdir $target/output
        else
        mkdir $target/output
    fi
    cl;
    bnr;
    info;
    brs;
    echo -e  "${ku}Sedang memproses...${no}";
    brs;
    api="$(cat /sdcard/ADU_Tools/system/build.prop | grep "ro.build.version.sdk" | cut -d"=" -f 2)"
    if [[ $api = "21" ]]; then
			is="1"
		elif [[ $api = "22" ]]; then
			is="2"
		elif [[ $api = "23" ]]; then
			is="3"
		elif [[ $api -ge "24" ]]; then
			is="4"
    fi
    echo $is | $img2d $target/sparse.img /sdcard/ADU_Tools/output >>$logs/repack_log.txt
    rm -r $target/sparse.img
    udone;
else
    miss;
fi
}
menu_dat() {
cl
bnr;
info;
brs;
dat_menu_info="${tbl}${ku}Android DAT menu:${no}

  1. Bongkar DAT
  2. ${dim}Repack DAT${no}
  3. ${ku}Kembali ke menu utama${no}"
echo -e "$dat_menu_info"
brs;
echo -e "${ku}Pilih menu kemudian tekan ENTER:${no}";
brs;
read env;
case $env in
 1|1) unpack;;
 2|2) repackalrt;;
 3|3) main;;
 *) winput;;
esac
}
menu_lainnya() {
cl
bnr;
info;
brs;
menu_lainnya_info="${tbl}${ku}Menu lainnya:${no}

  1. Install Ubuntu 18 Bionic
  2. ${ku}Kembali ke menu utama${no}"
echo -e "$menu_lainnya_info"
brs;
echo -e "${ku}Pilih menu kemudian tekan ENTER:${no}";
brs;
read env;
case $env in
 1|1) installubuntu;;
 2|2) main;;
 *) winput;;
esac
}
informasi() {
cl;
bnr;
info;
brs;
informasi_info="${tbl}${ku}Tentang Tools:${no}

Kontributor:
  • rendiix (owner)
  • (menunggu yg bersedia)
  •

Kredit:
  • xpirt@xda untuk sdat2img.py
  • 

Donasi:
Kami sangat berterima kasih untuk berpapun donasi yang diberikan,

  • rendiix: 0812-2514-5217 (hanya menerima dlm bentuk pulsa)
  • "

echo -e "$informasi_info"
jda;
main;
}

main() {
cl
bnr;
info;
brs;
maininfo="${tbl}${ku}Menu utama:${no}

  1. DAT menu     4. Menu lain-lain
  2. ${dim}ROM menu${no}     5. Informasi
  3. ${dim}BOOT menu${no}    6. ${me}Keluar${no}"
echo -e "$maininfo"
brs;
echo -e "${ku}Pilih menu kemudian tekan ENTER:${no}";
brs;
read env;
case $env in
 1|1) menu_dat;;
 2|2) csoon;;
 3|3) csoon;;
 4|4) menu_lainnya;;
 5|5) informasi;;
 6|6) quit;;
 *) winput;;
esac
}

root=$(pwd)
target="/sdcard/ADU_Tools"
img2s="$root/tools/img2simg"
img2d="$root/tools/img2sdat.py"
mext="$root/tools/make_ext4fs"
fosys="$target/system"
cntx="$target/file_contexts.bin"
outdat="$target/output/"
build="/system/build.prop"
model="$(cat $build | grep "ro.product.model" | cut -d"=" -f 2)"
brand="$(cat $build | grep "ro.product.brand" | cut -d"=" -f 2)"
verand="$(cat $build | grep "ro.build.version.release" | cut -d"=" -f 2)"
mem="$(df -h | grep "/data" | tr -s " " | cut -d" " -f 4)"
mem2="$(df | grep "/data" | tr -s " " | cut -d" " -f 4)"
d2img="$root/tools/sdat2img.py"
sdat="$target/system.new.dat"
tfrl="$target/system.transfer.list"
logs="$target/logs"
envj() {
pkg update && pkg upgrade -assume-yes
pkg install -y python readline coreutils unzip tar file figlet curl wget grep ncurses-utils fish p7zip zip pv
}
if [ -d $target ]; then
    main;
else
    mkdir $target
    mkdir $target/logs
    chmod -R +x ${root}/tools/*
    envj;
    main;
fi