# emr-alluxio
alluxio - emr bootstrap action scripts

# emr cluster conf

```
[
  {
    "Classification": "core-site",
    "Properties": {
      "fs.alluxio.impl": "alluxio.hadoop.FileSystem"
    }
  },
  {
    "Classification": "spark-defaults",
    "Properties": {
          "spark.driver.extraClassPath": ":/usr/lib/hadoop-lzo/lib/*:/usr/lib/hadoop/hadoop-aws.jar:/usr/share/aws/aws-java-sdk/*:/usr/share/aws/emr/emrfs/conf:/usr/share/aws/emr/emrfs/lib/*:/usr/share/aws/emr/emrfs/auxlib/*:/usr/share/aws/emr/security/conf:/usr/share/aws/emr/security/lib/*:/opt/alluxio-core-client-spark-1.2.0-jar-with-dependencies.jar"
     }
  }
]
```
