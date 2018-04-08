#!/bin/bash

#------------------------------------------------------------------------------------------------------
# Credit to: xpirt for sdat2img.py - dan semua yang berkontribusi 
#------------------------------------------------------------------------------------------------------
# Provided by: rendiix

me="\e[38;5;196m"
hi="\e[38;5;82m"
ku="\e[38;5;226m"
bi="\e[38;5;21m"
tbl="\e[1m"
dim="\e[2m"
no="\e[0m"
bnr() {
	echo -e ""
	echo -e "------------------------------------------------------"
	echo -e "            ${hi}${tbl}Android DAT Unpacker Tool${no}                "
	echo -e "                  ${ku}by Gunkid Dev${no}                       "
	echo -e "------------------------------------------------------"
}
brs() {
    echo -e ""
	echo -e "------------------------------------------------------"
	echo -e ""
}
info() {
echo -e "";
echo -e "${tbl}Device info:${no}";
echo -e "";
echo -e "  Model         : ${hi}$brand - $model${no}";
echo -e "  Versi Android : ${hi}$verand${no}";
echo -e "  Memori tersisa: ${hi}$mem${no}";
}
jda() {
brs;
read -s -n 1 -p "Kembali ke menu utama..."
}
csoon() {
cl;
bnr;
info;
brs;
echo -e "${hi}Fiture akan ditambahkan, dev lagi bertapa nyari materi";
echo -e "Bagi yang ingin ikut berkontribusi silahkan kontak saya di:";
echo -e " • Email   : vanzdobz@gmail.com";
echo -e " • Phone   : +62812 **** ****";
echo -e " • Discord : -${no}";
jda;
main;
}
winput() {
brs;
echo -e "${me}Masukan salah, coba lagi${no}";
jda;
main;
}
memwarn() {
cl;
bnr;
info;
brs;
echo -e "${me}Penyimpanan tidak cukup, pastikan ruang kosong lebih dari 5 GB${no}";
jda;
main;
}
miss() {
cl;
bnr;
info;
brs;
echo -e "${me}File yg dibutuhkan tidak lengkap...${no}";
echo -e "";
echo -e "${ku}Pastikan sudah memasukkan file:${no}";
echo -e "${tbl}system.new.dat${no} ${ku}dan${no} ${tbl}system.transfer.list${no}";
echo -e "${ku}kedalam folder:${no} ${tbl}$target${no}"
jda;
main;
}
udone() {
cl;
bnr;
info;
brs;
echo -e "${hi}Proses selesai...${no}";
jda;
main;
}
quit() {
exit
}
cl() {
clear
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
    echo -e  "${ku}Sedang memproses...${no}";
    brs;
    $d2img $tfrl $sdat $target/system.img 2>/dev/null >> $logs/unpack_log.txt
    cl;
bnr;
info;
brs;
echo -e "${hi}Proses convert DAT ke RAW.img selesai...";
echo -e "Selanjutnya gunakan Zharchive dari playstore untuk";
echo -e "membuka atau mengekstrak *.img file${no}";
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
echo -e "${tbl}Menu:${no}";
echo -e "";
echo -e "  1. Bongkar DAT";
echo -e "  2. Repack DAT";
echo -e "${dim}  3. BOOT Tools (comming soon)${no}";
echo -e "  4. Keluar";
brs;
printf %s "Pilih menu kemudian tekan ENTER: ";
echo -e ""
brs;
read env;
case $env in
 1|1) unpack;;
 2|2) repack;;
 3|3) csoon;;
 4|4) quit;;
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
    bnr;
    echo -e "${ku}Memeriksa tools... hanya saat pertama kali menggunakan tools ini${no}"
    brs;
    chk="$(pkg list-installed python | grep "installed" | cut -d" " -f4)"
   if [ "$chk" = "" ]; then
         bnr;
         echo -e "${ku}Python tidak terinstall diperangkat anda${no}"
         brs;
         echo -e "${ku}Memasang Python...${no}"
         pkg install java
         main;
         else
         bnr;
         echo -e "${hi}Python: OK!${no}"
         brs;
         main;
   fi
}
if [ -d $target ]; then
    main;
else
    mkdir $target
    mkdir $target/logs
    envj;
    main;
fi