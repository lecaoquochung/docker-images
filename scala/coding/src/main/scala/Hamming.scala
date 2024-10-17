// https://rosalind.info/problems/hamm/
object Hamming {
  def distance(dnaStrandOne: String, dnaStrandTwo: String): Option[Int] = 
    if (dnaStrandOne.length == dnaStrandTwo.length)
      Some(dnaStrandOne zip dnaStrandTwo count { case (a, b) => a != b })
    else
      None
}

// tweak
// def distance(dnaStrandOne: String, dnaStrandTwo: String): Either[String, Int] = {
//   def isValidDNA(strand: String): Boolean = strand.forall(Set('A', 'C', 'G', 'T'))

//   if (!isValidDNA(dnaStrandOne) || !isValidDNA(dnaStrandTwo))
//     Left("Invalid DNA strand. DNA strands can only contain A, C, G, and T.")
//   else if (dnaStrandOne.length != dnaStrandTwo.length)
//     Left(s"DNA strands must be of equal length. Got ${dnaStrandOne.length} and ${dnaStrandTwo.length}.")
//   else
//     Right(dnaStrandOne zip dnaStrandTwo count { case (a, b) => a != b })
// }