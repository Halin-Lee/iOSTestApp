<?php 

const PRIVATE_KEY = <<<EOD
-----BEGIN RSA PRIVATE KEY-----
MIICXQIBAAKBgQC8JM3/26Bgl/fWHE+tZwQnwMDMlqk2ZXdy9kea15gIbEh7zVyw
+G2y5q9Y52afi57mJFPPmsa8uca3SJvGxWEbVAsq81/PfXsmZrogMxJleMFRFctI
s+JywmmAYRjDvypjALxx6pv9T8qvhg01O3zMqIrnCNvcIpT+eDUe0+xZZwIDAQAB
AoGBAItEszgx2wWleE+FpXU2TF0g0Zaf76HUehcfNuHntSKHBSCfY32cZ5eGK0Yk
BFMVhwnU2jVS3MnWusHxfV4lvTq4ONRWok2J+OqFAxT+6bLH7ALW9tr7gnbNm6jI
uNVzpchjA4ZAoXOeGYyj7mmeLKb2tjf40MT5PBlhyIZRERABAkEA5eNJXbOWlDu8
WWTUuE2olmq/YGWg3rOetFaryasKaD+ADbS5abHtb/Oo4u/TstYEDw17nRH0uQEk
7WALcGyWdwJBANGDrX4Uul27FaFbPJvffnrUfGp0QI8eA5cYSOqrtQ1RPWovsWOo
8SSq5TcRJrPDdq6c64K1UGTX+SGefU0V4JECQQCs7rF9/17C27zwMl2i1yh/HoYg
adL+NHiqiJhp+HS3vy0BInZoACTxFoZxUKAb48rh1+6pVZyWnzm8J4fzZnw5AkBV
vZGOe2UZXqqncfMHxxq3oaWY2yJgb2QAvYt5nfNmE80SW5o4sraczuMm+fngryku
pEEtKI5R9qCZxYZ5uW5BAkAMH6AUa8awSoWKlF2Zu7IMOxmec824bn3AHP1Z4fpk
Q8sVuUhx0cprqri8Oqa9iu2e8FXmlToKQ6hwBzI6M5Ew
-----END RSA PRIVATE KEY-----
EOD;

$files = "";
$zipFile = "script.zip";
$finalFile = "v1";
for ($i = 1; $i < count($argv); $i ++) {
    if ($argv[$i] == '-o') {
        $finalFile = $argv[$i + 1];
        break;
    }
    $files .= $argv[$i] . " ";
}

if (!empty($files)) {

    //compress files
    echo system("zip $zipFile $files"); 

    //get and encrypt zip file's md5
    $zipFileMD5 = md5_file($zipFile);
    $private_key = openssl_pkey_get_private(PRIVATE_KEY);
    $ret = openssl_private_encrypt($zipFileMD5, $encrypted, $private_key);

    if (!$ret || empty($encrypted)) {
        unlink($zipFile);
        echo "fail to encrypt file md5";
    }

    $md5File = "key";
    file_put_contents($md5File, $encrypted);

    //pack script zip file and md5 file to final zip file
    echo system("zip $finalFile $zipFile $md5File"); 

    unlink($md5File);
    unlink($zipFile);
}
