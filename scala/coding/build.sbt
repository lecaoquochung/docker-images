val scala3Version = "3.3.1"

lazy val root = project
  .in(file("."))
  .settings(
    name := "coding",
    version := "0.1.0-SNAPSHOT",
    scalaVersion := scala3Version,
    scalacOptions += "-Yrangepos",
    
    libraryDependencies ++= Seq(
      "org.scalameta" %% "munit" % "1.0.0" % Test,
      "org.scalatest" %% "scalatest" % "3.2.17" % Test
    )
  )
