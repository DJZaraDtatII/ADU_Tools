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
tbl="\e[1m"
dim="\e[2m"
no="\e[0m"
bnr() {
banner="${tbl}${mag}
==================================================
=${tbl}${hi}            Android DAT Unpacker ${no}     ${tbl}${mag}          =
=   ${ku}             by Gunkid Dev ${no}      ${tbl}${mag}            =
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
dev lagi bertapa nyari materi

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

${me}Fitur repack sementara dihilangkan,
permasalahan cross compile binary ${bi}make_ext4fs${no}
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

main() {
cl
bnr
info;
brs;
maininfo="${tbl}${ku}Menu:${no}

  1. Bongkar DAT    4. Dump *.img dari device
  2. ${dim}Repack DAT${no}     5. Kontributor + credit
  3. ${dim}BOOT Tools${no}     6. ${me}Keluar${no}"
echo -e "$maininfo"
brs;
echo -e "${ku}Pilih menu kemudian tekan ENTER:${no}";
brs;
read env;
case $env in
 1|1) unpack;;
 2|2) repackalrt;;
 3|3) csoon;;
 4|4) csoon;;
 5|5) csoon;;
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
pkg install -y python readline coreutils unzip tar file figlet curl wget grep ncurses-utils p7zip zip pv
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