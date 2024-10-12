// https://rosalind.info/problems/hamm/
object Hamming {
  def distance(dnaStrandOne: String, dnaStrandTwo: String): Option[Int] = 
    if (dnaStrandOne.length == dnaStrandTwo.length)
      Some(dnaStrandOne zip dnaStrandTwo count { case (a, b) => a != b })
    else
      None
}