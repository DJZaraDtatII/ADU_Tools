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
info="${tbl}${ku}
Device info: ${no}

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
bnr;
info;
brs;
echo -e "${tbl}${ku}Info:${no}"
txtinfo;
jda;
main;
}
repackalrt() {
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
bnr;
info;
brs;
echo -e "${me}${tbl}Penyimpanan tidak cukup, pastikan ruang kosong lebih dari 5 GB${no}";
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
echo -e "$missinfo"
jda;
main;
}
udone() {
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
atau dengan mengetikkan perintah ${mag}startubuntu${no}
${ku}
Silahkan restart termux${no}"
echo -e "$ubuntud"
jda;
main;
}
installubuntu() {
bnr;
info;
brs;
cd ~/
echo -e "${ku}Cloning repositories...${no}$mag"
echo ""
git clone https://github.com/rendiix/ubuntu-chroot.git
cd ~/ubuntu-chroot/
echo ""
echo -e "${ku}Memasang ubuntu...${no}$mag"
echo ""
chmod +x ubuntu.sh
./ubuntu.sh
cd $root
termuxstart;
}
termuxstart() {
prof=/data/data/com.termux/files/usr/etc/profile
motd=/data/data/com.termux/files/usr/etc/motd
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
get_imgsize() {
imgsize="$(wc -c $target/system.img | cut -d" " -f1)"
echo -e "$imgsize" > $target/logs/imgsize.txt
}
unpackmain() {
if [[ -e $sdat && -e $tfrl ]]; then
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
echo -e "${ku}${tbl}Extract RAW.img ke folder system...${no}";
echo -e "$mag"
if [ -d $target/system ]; then
rm -r $target/system
fi
mkdir $target/system
7z x -o$target/system/ $target/system.img
echo -e "$no"
echo -e "${hi}Unpack selesai...${no}";
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
choice=1
while [[ $choice != 0 ]]; do
menu_img_size="
${ku}Masukkan ukuran partisi:$mag

  1. Otomatis dari *.img saat ini
  2. Manual

"
echo -e "$menu_img_size"
read -n 1 -p "Masukkan pilihan:" choice
 case $choice in
        "1" ) echo -e "" 
              echo -e "Menggunakan ukuran partisi saat ini $size"
              size="$(cat $target/logs/imgsize.txt)"
              ukuran=$size
              echo -e "$no"
              break ;;
        "2" ) echo -e ""
              read -p "Masukkan ukuran:" size
              echo -e "Ukuran partisi $ukuran"
              ukuran=$size
              echo -e "$no"
              break ;;
        * ) echo -e ""
            echo -e "${me}Masukan salah! Mohon coba kembali.${no}"
            echo -e ""
 esac
done
}

repack() {
fosys="$target/system"
if [ -f "$target/file_contexts.bin" ]; then
bnr;
echo -e "${ku}Convert file_contexts.bin..."
echo -e "$no"
$fc_con -x $target/file_contexts.bin $target/
sleep 3
fi
cntx="$target/file_contexts"
if [[ -e $fosys && -e $cntx ]]; then
    insert_imgsize;
    bnr;
    echo -e "${ku}Membuat sparse img..."
    echo -e "$mag"
    $mext -T -0 -S $cntx -l ${ukuran} -a system $target/raw.img $target/system/
    $img2s $target/raw.img $target/sparse.img 4096 >$logs/repack_log.txt
    rm -r $target/raw.img
    if [ -d "$target/output/" ]; then
        rm -r $target/output
        mkdir $target/output
        else
        mkdir $target/output
    fi
    bnr;
    echo -e "${ku}Membuat DAT file...${no}";
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
    echo $is | $img2d $target/sparse.img /sdcard/ADU_Tools/output >$logs/repack_log.txt
    rm -r $target/sparse.img
    udone;
else
    miss;
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
read env;
case $env in
 1|1) unpack;;
 2|2) repack;;
 3|3) main;;
 *) winput;;
esac
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
read env;
case $env in
 1|1) installubuntu;;
 2|2) main;;
 *) winput;;
esac
}
informasi() {
bnr;
info;
brs;
informasi_info="${tbl}${ku}Tentang Tools:${no}

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
  • "

echo -e "$informasi_info"
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
echo -e "${ku}Memeriksa pembaruan silahkan tunggu...${no}"
newv="$(curl -s curl https://raw.githubusercontent.com/rendiix/ADU_Tools/master/README.md | grep "ADU_Tools V" | cut -d" " -f3 | cut -d"." -f3)"
curv="$(grep "ADU_Tools V" README.md | cut -d" " -f3 | cut -d"." -f3)"
if [ -z "$newv" ]; then
bnr;
info;
brs;
echo -e "${me}Tidak dapat memeriksa pembaruan!${no}"
sleep 2
main;
else 
if [ "$curv" -eq "$newv" ]; then
bnr;
info;
brs;
echo -e "${hi}Versi $newv sudah yang terbaru${no}"
sleep 2
main;
else
 if [ "$curv" -lt "$newv" ]; then
update_avail="
 y. Install pembaruan v$newv
"
update_avail_info="Update tersedia"
update_menu;
fi
fi
fi
}
update() {
bnr;
echo -e "${ku}Memasang pembaruan...$no"
echo -e "$mag"
mkdir temp
wget https://codeload.github.com/rendiix/ADU_Tools/zip/master -O $root/temp/adu.zip
7z x -o$root/temp/ $root/temp/adu.zip
cp -R $root/temp/*/* $root
rm -R $root/temp
chmod +x *
chmod +x tools/*
bnr;
echo -e "${hi}Install pembaruan selesai...${no}"
echo -e ""
echo -e "Memulai ulang tools..."
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
read env;
case $env in
 1|1) autocheck_update;;
 2|2) check_update;;
 3|3) main;;
 4|4) quit;;
 y|y) update;;
 *) update_menu;;
esac
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
brs;
read env;
case $env in
 1|1) menu_dat;;
 2|2) csoon;;
 3|3) csoon;;
 4|4) menu_lainnya;;
 5|5) informasi;;
 6|6) update_menu;;
 7|7) quit;;
 *) winput;;
esac
}

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
info;
brs;
echo -e "${ku}Memasang dependency..."
echo -e "$mag"
pkg update && pkg upgrade --assume-yes
pkg install -y python readline coreutils unzip tar file figlet curl wget gnupg2 grep ncurses-utils fish p7zip zip pv proot
brs;
echo -e "${ku}Memasang repo-pointless..."
echo -e "$mag"
mkdir $PREFIX/etc/apt/sources.list.d
echo "deb [trusted=yes] https://its-pointless.github.io/files/ termux extras" > $PREFIX/etc/apt/sources.list.d/pointless.list
wget https://its-pointless.github.io/pointless.gpg
apt-key add pointless.gpg
apt update
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
