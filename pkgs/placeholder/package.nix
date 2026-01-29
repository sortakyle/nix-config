{writeScriptBin, ...}:
writeScriptBin "hello-world" ''
  echo "Hello, World!"
''
