<?php
function query($sql)
{
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "btth01_cse485";
    $port = 3307;
    try {
        $conn = new PDO("mysql:host=$servername;port=$port;dbname=$dbname", $username, $password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $conn->exec($sql);
        return 1;
    } catch (PDOException $e) {
        echo $sql . "<br>" . $e->getMessage();
    }
    $conn = null;
    return 0;
}

function query_select($selectSQL)
{
    $listData = [];
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "btth01_cse485";
    $port = 3307;
    try {
        $conn = new PDO("mysql:host=$servername;port=$port;dbname=$dbname", $username, $password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $stmt = $conn->prepare($selectSQL);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        foreach ($result as $key => $value) {
            $listData[$key] = $value;
        }
    } catch (PDOException $e) {
        echo "Error: " . $e->getMessage();
        return [];
    }
    $conn = null;
    return $listData;
}
