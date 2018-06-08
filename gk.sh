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
cl;
banner="${tbl}${mag}
==================================================
=${tbl}${bpu}${bi}             Android DAT Unpacker               ${no}${tbl}${mag}=
=${tbl}${bpu}${bi}                  by gk-dev                     ${no}${tbl}${mag}=
==================================================${no}

"
echo -e "$banner"
}
brs() {
    echo -e ""
	echo -e "${tbl}${mag}==================================================${no}"
	echo -e ""
}
info() {
curve=$(grep "ADU_Tools V" README.md | cut -d" " -f3)
info="${tbl}${ku}Device info: ${no}

  Model          : ${mag}$(getprop ro.product.manufacturer)-$(getprop ro.product.model) ($(getprop ro.product.name))${no}
  Versi Android  : ${mag}$(getprop ro.build.version.release)${no}
  Versi OS       : ${mag}$(getprop ro.build.version.incremental)${no}
  Memori tersisa : ${mag}$mem${no}
  Versi tools    : ${mag}$curve${no} ${hi}$update_avail_info${no}"
echo -e "$info"
}
jda() {
brs;
read -s -n 1 -p "Kembali ke menu utama..."
}
about_info() {
csooninfo="

${hi}Fiture akan segera ditambahkan,
dev lagi bertapa nyari materi.

Bagi yang ingin ikut berkontribusi silahkan
kontak saya di:
 
 • Email   : vanzdobz@gmail.com
 • Phone   : +62812 2514 5xxx
 • Fb      : -
 • Discord : -${no}"
p "$csooninfo"
}
csoon() {
bnr;
info;
brs;
echo -e "${tbl}${ku}Info:${no}"
about_info;
jda;
main;
}
disable_menu_alert() {
bnr;
info;
brs;
repackinfo="${tbl}${ku}Info:${no}

${me}  Fiture untuk sementara dinonaktifkan!

Permasalahan cross compile binary ${bi}make_ext4fs${no}
${me}yang belum support untuk Android.${no}"

p "$repackinfo"
about_info;
jda;
main;
}
memwarn() {
bnr;
info;
brs;
p "${me}${tbl}Penyimpanan tidak cukup, pastikan ruang kosong lebih dari 5 GB${no}";
jda;
main;
}
miss() {
bnr;
info;
brs;
missinfo="${me}File yg dibutuhkan tidak lengkap...${no}

${ku}Pastikan sudah memasukkan file:${no}
${tbl}system.new.dat${no} ${ku}dan${no} ${tbl}system.transfer.list${no}
${ku}kedalam folder:${no} ${tbl}$target${no}"
p "$missinfo"
jda;
main;
}
udone() {
bnr;
info;
brs;
p "${hi}Proses selesai...${no}";
jda;
main;
}
quit() {
bnr;
p "${hi}Terima kasih sudah menggunakan ADU_Tools.
Jika tools ini bermanfaat silahkan share, report bugs,
atau donasi seiklasnya.$no

${bi}gk-dev${no}"
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
bnr;
info;
brs;
ubuntud="${hi}Instalasi ubuntu selesai...
Anda dapat memulai Ubuntu dari start screen
atau dengan mengetikkan perintah ${mag}ubuntu${no}
${ku}
Silahkan restart termux${no}"
p "$ubuntud"
jda;
main;
}
installubuntu() {
bnr;
info;
brs;
cd ~/
p "${ku}Cloning repositories...${no}$mag"
echo ""
git clone https://github.com/rendiix/ubuntu-chroot.git
cd ~/ubuntu-chroot/
echo ""
p "${ku}Memasang ubuntu...${no}$mag"
echo ""
chmod +x ubuntu.sh
./ubuntu.sh
cd $root
termuxstart;
}
termuxstart() {
prof=$PREFIX/etc/profile
motd=$PREFIX/etc/motd
bnr;
info;
brs;
p "${ku}Menambahkan Termux start screen...$no"
brs;
p "${ku}Masukkan nama anda...

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
ubuntu
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
while read env; do
case $env in
 1) ubuntu; break;;
 2) termux; break;;
 *) echo -e "${me}Masukan salah!${no}";;
esac
done
}
start;
EOM
sed -i "s/ganti_nama/$nama/g" $prof
ubuntu_done;
}
get_imgsize() {
imgsize="$(wc -c $target/system.img | cut -d" " -f1)"
echo -e "$imgsize" > $target/logs/imgsize.txt
}
unpackmain() {
if [[ -e $sdat && -e $tfrl ]]; then
    bnr;
    info;
    brs;
    p  "${ku}Covert DAT ke RAW.img...${no}";
    brs;
    pv $target/system.img | $d2img $tfrl $sdat $target/system.img 2>/dev/null >> $logs/unpack_log.txt
    cl;
bnr;
info;
brs;
p "${ku}${tbl}Extract RAW.img ke folder system...${no}";
echo -e "$mag"
if [ -d $target/system ]; then
rm -r $target/system
fi
mkdir $target/system
7z x -o$target/system/ $target/system.img
echo -e "$no"
p "${hi}Unpack selesai...${no}";
get_imgsize;
rm $target/system.img
jda;
main;
else
    miss;
fi
}
insert_imgsize() {
bnr;
menu_img_size="
${ku}Masukkan ukuran partisi:$mag

  1. Otomatis dari *.img saat ini
  2. Manual

"
echo -e "$menu_img_size"
while read env; do
 case $env in
        1) echo -e "" 
              p "Menggunakan ukuran partisi saat ini $size"
              size="$(cat $target/logs/imgsize.txt)"
              ukuran=$size
              echo -e "$no"
              break ;;
        2) echo -e ""
              read -p "Masukkan ukuran:" size
              p "\nUkuran partisi $size"
              ukuran=$size
              echo -e "$no"
              break ;;
        *) echo -e "\n${me}Masukan salah! Mohon coba kembali.${no}\n";;
 esac
done
}

repack() {
fosys="$target/system"
if [ -f "$target/file_contexts.bin" ]; then
bnr;
p "${ku}Ditemukan${no} file_contexts.bin

${ku}Convert${no} file_contexts.bin ${ku}ke${no} file_contexts

${ku}Mohon tunggu"
echo -e "$no"
$fc_con -x $target/file_contexts.bin $target/
sleep 3
fi
cntx="$target/file_contexts"
if [[ -e $fosys && -e $cntx ]]; then
    insert_imgsize;
    bnr;
    info;
    brs;
    p "${ku}Membuat raw img..."
    echo -e "$mag"
    $mext -T -0 -S $cntx -L system -l ${ukuran} -a system $target/raw.img $target/system/
    bnr;
    info;
    brs;
    p "${ku}Membuat sparse img..."
    echo -e "$mag"
    $img2s $target/raw.img $target/sparse.img 4096 >$logs/repack_log.txt
    rm -r $target/raw.img
    if [ -d "$target/output/" ]; then
        rm -r $target/output
        mkdir $target/output
        else
        mkdir $target/output
    fi
    bnr;
    info;
    brs;
    p "${ku}Membuat DAT file...${no}";
    echo -e "$mag"
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
    $img2d $target/sparse.img -o /sdcard/ADU_Tools/output -v ${is}
    rm -r $target/sparse.img
     p "\n${hi}Selesai... file tersimpan di:$no

$target/output"
    sleep 5
    exec $root/gk.sh
else
    p "
${me}Tidak ada file${no} file_contexts/file_contexts.bin ${me}atau folder${no} system"
    sleep 2
    menu_dat;
fi
}
menu_dat() {
bnr;
info;
brs;
dat_menu_info="${tbl}${ku}Android DAT menu:${no}

  1. Bongkar DAT
  2. Repack DAT
  3. ${ku}Kembali ke menu utama${no}"
echo -e "$dat_menu_info"
brs;
echo -e "${ku}Pilih menu kemudian tekan ENTER:${no}";
brs;
while read env; do
case $env in
 1) unpack; break;;
 2) repack; break;;
 3) main; break;;
 *) echo -e "${me}Masukan salah!${no}";;
esac
done
}
menu_lainnya() {
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
while read env; do
case $env in
 1) installubuntu; break;;
 2) main; break;;
 *) echo -e "${me}Masukan salah!${no}";;
esac
done
}
informasi() {
bnr;
info;
brs;
informasi_info="${tbl}${ku}Tentang Tools:${no}
$mag
Kontributor:
  • rendiix (owner)
  • 
  •

Kredit:
  • xpirt@xda untuk sdat2img.py
  • 

Donasi:
Kami sangat berterima kasih untuk berpapun donasi yang diberikan,

  • rendiix: 0812-2514-5217 (hanya menerima dlm bentuk pulsa)
  • ${no}"

p "$informasi_info"
jda;
main;
}
run_check_update() {
  if [[ "$auto_update_check" == "hidup" ]]; then
    check_update;
  else
    main;
  fi
}
check_update(){
bnr;
info;
brs;
p "${ku}Memeriksa pembaruan silahkan tunggu...${no}"
newv="$(curl -s curl https://raw.githubusercontent.com/rendiix/ADU_Tools/master/README.md | grep "ADU_Tools V" | cut -d" " -f3 | cut -d"." -f3)"
curv="$(grep "ADU_Tools V" README.md | cut -d" " -f3 | cut -d"." -f3)"
if [ -z "$newv" ]; then
bnr;
info;
brs;
p "${me}Tidak dapat memeriksa pembaruan!${no}"
sleep 2
main;
else 
if [ "$curv" -eq "$newv" ]; then
bnr;
info;
brs;
p "${hi}Versi $newv sudah yang terbaru${no}"
sleep 2
main;
else
 if [ "$curv" -lt "$newv" ]; then
update_avail="
 ${mag}y. Install pembaruan v$newv${no}
"
update_avail_info="Update tersedia"
update_menu;
fi
fi
fi
}
update() {
bnr;
p "${ku}Memasang pembaruan...$no"
echo -e "$mag"
mkdir temp
wget https://codeload.github.com/rendiix/ADU_Tools/zip/master -O $root/temp/adu.zip
7z x -o$root/temp/ $root/temp/adu.zip
cp -R $root/temp/*/* $root
rm -R $root/temp
chmod +x *
chmod +x tools/*
bnr;
p "${hi}Install pembaruan selesai...${no}"
echo -e ""
p "Memulai ulang tools..."
sleep 4
exec $root/gk.sh
}
autocheck_update() {
if [[ "$autocheck_update_info" == "hidup" ]]; then
  echo -e "$mag"
  toggle_auto_update="Nonaktifkan pembaruan otomatis? [y/n]"
  choice=""
  read -n 1 -p "$toggle_auto_update" choice
    if [[ $choice = "y" ]]; then
    cat > $root/tools/auto_update <<- EOM
mati
EOM
echo -e "$no"
update_menu;
    else
    update_menu;
    fi
  else
  echo -e "$mag"
  toggle_auto_update="Hidupkan pembaruan otomatis? [y/n]"
  choice=""
  read -n 1 -p "$toggle_auto_update" choice
    if [[ $choice = "y" ]]; then
    cat > $root/tools/auto_update <<- EOM
hidup
EOM
echo -e "$no"
update_menu;
    else
    update_menu;
    fi
fi
}

update_menu() {
bnr;
info;
brs;
autocheck_update_info="$(cat $root/tools/auto_update)"
update_menu_info="${tbl}${ku}Menu pembaruan:${no} ${hi}${update_avail_info}${no}
$update_avail
 1. Otomatis periksa pembaruan [${mag}${autocheck_update_info}${no}]
 2. Periksa pembaruan
 3. ${ku}Ke menu utama${no}
 4. ${me}Keluar${no}"
echo -e "$update_menu_info"
echo -e ""
echo -e "Masukkan pilihan:"
while read env; do
case $env in
 1) autocheck_update; break;;
 2) check_update; break;;
 3) main; break;;
 4) quit; break;;
 y) update; break;;
 *) echo -e "${me}Masukan salah!${no}";;
esac
done
}
main() {
bnr;
info;
brs;
maininfo="${tbl}${ku}Menu utama:${no}

  1. DAT menu     5. Infomasi
  2. ${dim}ROM menu${no}     6. Pembaruan 
  3. ${dim}BOOT menu${no}    7. ${me}Keluar${no}
  4. Lainya"
echo -e "$maininfo"
brs;
echo -e "${ku}Pilih menu kemudian tekan ENTER:${no}";
while read env; do
case $env in
 1) menu_dat; break;;
 2) csoon; break;;
 3) csoon; break;;
 4) menu_lainnya; break;;
 5) informasi; break;;
 6) update_menu; break;;
 7) quit; break;;
 *) echo -e "${me}Masukan salah!${no}";;
esac
done
}
. ./tools/demo -w1
DEMO_PROMPT=""
root=$(pwd)
target="/sdcard/ADU_Tools"
img2s="$root/tools/img2simg"
img2d="$root/tools/img2sdat.py"
fc_con="$root/tools/fc_convert"
mext="$root/tools/make_ext4fs"
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
auto_update_check="$(cat $root/tools/auto_update)"
envj() {
bnr;
p "${ku}Memasang dependency..."
echo -e "$mag"
pkg update && pkg upgrade --assume-yes
pkg install -y python readline coreutils unzip tar file figlet curl wget gnup* grep ncurs* fish p7zip zip pv proot
echo -e "\n${hi}Selesai..."
sleep 2
bnr;
p "${ku}Memasang repo-pointless..."
echo -e "$mag"
mkdir $PREFIX/etc/apt/sources.list.d
echo "deb [trusted=yes] https://its-pointless.github.io/files/ termux extras" > $PREFIX/etc/apt/sources.list.d/pointless.list
wget https://its-pointless.github.io/pointless.gpg
apt-key add pointless.gpg
apt update
rm pointless.gpg
echo -e "\n${hi}Selesai..."
sleep 2
bnr;
p "\n${ku}Membuat pintasan ADU_Tools...${no}\n"
launcher="$PREFIX/bin/gkdev"
cat > $launcher <<- EOM
#!$PREFIX/bin/bash
cd $root/
./gk.sh

EOM
chmod 777 $launcher
sleep 2
p "\n${hi}Selesai!\n${no}\n${mag}Selanjutnya anda dapat memulai tools dengan\nmengetikkan${no} gkdev${mag} pada terminal.${no}"
sleep 5
}
if [ -d $target ]; then
    run_check_update;
else
    mkdir $target
    mkdir $target/logs
    chmod -R +x ${root}/tools/*
    envj;
    run_check_update;
fi
