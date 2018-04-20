#!/bin/bash

# A script to install the password testing program John the Ripper
# on Juur (juur.grid.eenet.ee)
# http://www.openwall.com/john/ 
# Example from
# http://www.openwall.com/lists/john-users/2010/06/20/2

# Load appropriate modules
module purge
module load cuda-5.0
module load gcc-4.6.4

export RipperDIR=RipperGPU
# Go to home directory
cd $HOME
# Make a source directory
mkdir $RipperDIR
# Go into the source directory
cd $RipperDIR
# Get the password testing program
wget download.openwall.net/pub/projects/john/1.7.9/john-1.7.9-jumbo-7.tar.gz
# Decompress the password testing program sources
tar -xvf john-1.7.9-jumbo-7.tar.gz
# Go into the source directory
cd john-1.7.9-jumbo-7
cd src
# Build the source code with Nvidia Cuda capability
make linux-x86-64-cuda
# Go into the binary directory
cd ..
cd run
# Create a test file
touch testhash
echo 'test:$6$MDZEL9CQ$ZentsLbLWphRB2./B0xKv1vWPY9IBknYrcD.3SlY5RamKsnzlCSC4ImT3KWY8rXMbodbFA9wDrlf51DT3HgoW1:102:14::/home/test:/bin/sh' >>  testhash 
echo 'test:$6$dofn/L59$nygYCacync7RzPfYjWZ1OO6b8MZDETUzYP2SbJD0PPqXDjQ3caVlR8/O6G2DSMh.6X0Dzwre86QPifkEU22dW/:102:14::/home/test:/bin/sh' >> testhash 
echo 'robert:$6$U4dzp4gvMho3$hAUA8cpTUdHnNjuMFUtiXzd0NL85RMNihshXdks/7LD5zDVseUawK1JIotk5JVZoyacpHy.Vuja0b9GD2gZ0J.:14527:0:99999:7:::' >> testhash 
# Get leaked linkdin hashes following http://easymactips.blogspot.com.ee/2012/09/john-ripper-tutorial-examples-and.html
git clone https://github.com/hungtruong/LinkedIn-Password-Checker
cp LinkedIn-Password-Checker/combo_not.txt .
#Get examples from Openwall website http://openwall.info/wiki/john/sample-hashes
wget openwall.info/wiki/_media/john/pw-fake-unix.gz
gunzip pw-fake-unix.gz
sed -n 1,50p pw-fake-unix > shortened-pw-fake-unix.txt
# SHA512 hashes from https://md5hashing.net/hash/sha512
touch sha512hash
echo 'b109f3bbbc244eb82441917ed06d618b9008dd09b3befd1b5e07394c706a8bb980b1d7785e5976ec049b46df5f1326af5a2ea6d103fd07c95385ffab0cacbc86' >> sha512hash
echo '0336cc0059ea5819dd849e00fa3d182ff7d7e64c732212d20dbb01d1de6f38c711276d90b8b0b872f257aaf5bb37b1a3dd1da818770a97c8f86cdc99c158f5fc' >> sha512hash
echo 'f5ccc08d18d2d8f39bb1ce5f97de67435baa3403a761b5052d16a8f39702e82ad734f644347e714f773f8450e25872d010253d588d6a77ff716f681872e0ffb9' >> sha512hash
echo '96fe096dde6e55d89093ad4ebbd56d97cb205752a587cbb2eb88817978289137f389d41f3b6512e0513cc20d53bfc5ca665344ec1d9e23550ebe6785c01c3811' >> sha512hash
echo '2d408a0717ec188158278a796c689044361dc6fdde28d6f04973b80896e1823975cdbf12eb63f9e0591328ee235d80e9b5bf1aa6a44f4617ff3caf6400eb172d' >> sha512hash
echo 'ecd02eb09f157554a1f76cba3022ad727ab75103318fabd6a9ffc4405940a649730a7cb27259d0b4b79d8b4c8efa1f84dcec4645387bdfde81ce874a82a3af24' >> sha512hash
echo 'e788c9098e9af811c184fc759a95d743925c4ed2c3a25c0f23f8e44b920709d60ebfa47bde9fd25e2c257d9e49cdf0f6de1c35119493ea4d0d756f56de19366b' >> sha512hash
echo '6b3ceacee675ee9fecd36fb728ff01b83dd313e89f9ec86db8518110d1432c566d627323984c738633dd24723088715918d07d56d83e2981722a286d83fe5edc' >> sha512hash
echo 'c39330fd03b31b500a62af697224b36e69915258aea53f7a45396666f685c8a8d3b3c8f8bf0ffd6cbb4efdb85d04e599c9eadc749be5bc1ed70cabc89b5a094a' >> sha512hash
echo '6346bb38318937d90d05747009f10395683773f533beb4ea80fba8f974b19e37e9c5b7ab0869587f3bd3ca67303b4937fc0fcacf0f0d77960060dd9fab229d4c' >> sha512hash
echo 'f4307275e9512f8b70c35ec7ee6aadfe5987cad9eec4ce0219a2c9d9ecd52fcfb08ace6ae51f5a839fab923da13dbd8353857878170edd055a9f14aa0c4eb8d5' >> sha512hash
echo '8c178b5ecc13fab314bf4961208e5f88e9df338471bf05d435a048930d5e48be8f07927b2eaa510f14538cbd0570549bd1e62b6f1a603396643402c56550174c' >> sha512hash
echo 'a811a967c4ccd80a88348e98b0386cb97f374969a539b4c3e30025a14fab8ec2745a069f6eef69933ff138c3415c247fd8cc5c01466c15bdd04d26c1d6b0547b' >> sha512hash
echo 'b66ae955ec638e88500d1662279c0c2ffa6a7836e76793a40b99aef869ae00ec7ee33dec9b385fcbcadc38166e18b093ff5186232f9cb61eb0ce010384a5ce59' >> sha512hash
echo '15218c22d36c321a3d3758cab45f706295456a363f25e297d7a7ba99ae9f452e1d2620d494bcd642b7122a4b53e05d05c7c0ebe59822ab485c5c9a28a16bec13' >> sha512hash
echo '9a191a33b85b735a0a78df36c938ef180d8c9dcb99ffee4df300c97f9e3934fd47a0d050f32ec62d6d1bb631e6016e23ddcc0e175a425fb0892e74744f5de4f5' >> sha512hash
echo '17bca6c3a976f876a3fe5c7cdcf203fd1ecfbf496e35357bf59e0aa048e541d8487de65d549c48311698f5ec65d333fda26fd1f114d2d671f126c3725d7f839a' >> sha512hash
echo '0365db4e65430807bc95e82c6dd9f1b5246494971f42a92d5c0c20ad51dad68d4c91686c7b32cf8005d51ba1c26529335cded7c119f62cbb515df016f8503360' >> sha512hash
echo 'f191243b772da57258f365eae4d1dd22cbdaf196aed194aad2b6f48e94df3ace18b1b57fe39f8d6d7ab331aff7215fc9d19ab5b7621aa1c48a468bdefca88f16' >> sha512hash
echo '2bae46015543afc7c5f123f29bb165a4a1ec4e305ce9838a5020bbe7106121bf414a6d9567314e86415e387a0b5a305f692fda5e983c05e8325904aa0c473576' >> sha512hash
echo 'c9ee63a83465e1dc3f37467918c4bae1a56e85ebbacce05c84731a332b73b6ce0c5b32a8d9fc7f16385d98262129402b6fe9ddada5781177c11e32d0e3e17d79' >> sha512hash
echo '263adce0f04ee1eb3e75528ed5251724906bdd44c4265a1cd1185af010a4561e153833d1ea46df69764f2ece8e33199f8d787bf39cc51ebb406f15480c7e780e' >> sha512hash
echo '1175c47f3282e0869e20ce244c4fcf99e676718a1fc8bc89fe87d72cdb4700c20390c23b3ab9ee4dca07e80427db9d7683e31d099ab712e3d17a4109bf6b0d58' >> sha512hash
echo '2c159ca6c2533bcf460477c07e77b8ab46e785b4346768f790e4098dc5cb4d42546bf34e77389c748a5ae9c16c9f79bae4e139ae283a079cd5d99b31ed6c821f' >> sha512hash
echo '152ea642d2eaf6f5510b17ee7d8b992e305be7d0c73a4c89d9d427e0fa4c2bf3a1aeadfa3ba962a279f0d0f5294da509ab57b8659ccf6f9c13b110aad619e646' >> sha512hash


# Copy timing routine to current directory
cp /usr/bin/time .
# Create submission script
touch subscript
echo '#!/bin/bash' >> subscript
echo '# number of nodes and number of processors per node requested' >> subscript
echo '# in this case 1 compute node' >> subscript
echo '#SBATCH -N 1 ' >> subscript
echo '#SBATCH --gres=gpu:1' >> subscript
echo '#SBATCH --partition=gpu' >> subscript
echo '#SBATCH --constraint=K20' >> subscript
echo '# requested Wall-clock time.' >> subscript
echo '#SBATCH -t 20:10:00' >> subscript
echo '# name of the job, you may want to change this so it is unique to you' >> subscript
echo '#SBATCH -J JohnTest ' >> subscript
echo '# Email address to send a notification to, change "youremail" appropriately' >> subscript
echo '#SBATCH --mail-user=your.email@ut.ee' >> subscript
echo '# send a notification for job abort, begin and end' >> subscript
echo '#SBATCH --mail-type=all' >> subscript
echo ' ' >> subscript
echo '# Run the job' >> subscript
echo 'module purge' >> subscript
echo 'module load cuda-5.0' >> subscript
echo 'module load gcc-4.6.4 ' >> subscript
echo ' ' >> subscript
echo './time ./john --markov --format=raw-sha512-cuda sha512hash' >> subscript
# submit job
sbatch subscript

