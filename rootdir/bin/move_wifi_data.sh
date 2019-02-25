#!/system/bin/sh

# Copyright (c) 2018, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#     * Neither the name of The Linux Foundation nor the names of its
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
# ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#

DEST_PATH="/data/vendor/wifi"
FILES_MOVED="/data/vendor/wifi/moved"
SRC_PATH="/data/misc/wifi"
#//ifdef VENDOR_EDITOR
SRC_FILE="/data/misc/wifi/p2p_supplicant.conf"
#//endif /* VENDOR_EDIT */

if [ ! -f "$FILES_MOVED" ]; then
    #//ifdef VENDOR_EDITOR
    i="$SRC_FILE";
    #//else
    #for i in "$SRC_PATH/"*; do
    #//endif /* VENDOR_EDIT */
        dest_path=$DEST_PATH/"${i#$SRC_PATH/}"
        echo $dest_path
        if [ -d "$i" ]; then
             mkdir -p $dest_path -m 700
             mv $i "$DEST_PATH"
           else
                mv $i "$DEST_PATH"
        fi
        find $DEST_PATH -print0 | while IFS= read -r -d '' file
             do
                 chgrp wifi "$file"
             done
        echo $i
    #//ifdef VENDOR_EDITOR
    #//else
    #done
    #//endif /* VENDOR_EDIT */
    restorecon -R "$DEST_PATH"
    echo 1 > "$FILES_MOVED"
fi
