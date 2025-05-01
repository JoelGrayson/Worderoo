#!/bin/bash

cat <<EOF > ~/Downloads/Words.swift
//
//  Words.swift
//  Wordle
//
//  Created by Joel Grayson on 5/1/25.
//

// Multiline string
let wordsString = """
$(node generate-words.js)
"""


EOF

echo "Generated the words. Now drag and drop from the Downloads folder into your project (because that way Xcode recognizes that it is part of your project)"


