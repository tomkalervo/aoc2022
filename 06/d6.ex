defmodule D6 do
  def run do
    buffer =
      String.to_charlist(In.put1)

      find_code([], buffer, 0)
  end

  def find_code(code, [h|t], n) do
    # IO.inspect(code)
    if Enum.count(code) == 14 do
      n
    else
      find_code(member_acc([h],code,[]), t, n + 1)
    end
  end
  def member_acc(x, [], acc), do: [x|Enum.reverse(acc)]
  def member_acc(h, [h|_], acc), do: [h|Enum.reverse(acc)]
  def member_acc(x, [h|t], acc) do
    member_acc(x, t, [h|acc])
  end
end

defmodule In do
  @p1 """
  nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg
  """
  @p2 """
  bhzhtzzsczszsjjjzddfzdfzfjfzfbbnntnzznwzzvfvrrqmrmmdzzfqfhqhsqqpwpgwpppbtbnnstthmhrrsmmvsmmhjmjfmfsfjfnfnjjvcjjszjszjsszbznzbnzndzzmlldsdgdcddmqmfqqlcllbvllztzctzczdzttlmtlthtmhtmhmmszsllvzvdzzzsqzqbqccvfvcffzsfslfsllcglclwlvwvzzdsslggtzzgzdzmzddjljvvztttsgscsstztjztjztzvzwwthtftppnmpmmcpmmjlmjjjsfjsjppgcgwcggzffzwzbbmbrbprpqqpccfncfnffvcffsqqtzqzqwzwvzwwwbjbfbcbfblltnlnhhcthtvvzzfcfgfddlggbbshsggplglqqbrbggsvvzdvvlfvlvpvhhmggbrrnppjfjhffttfpffbdfbfvfqvvtcvvbvnnhbhhglgjgzzghhwrrtntrtwwfdfdmmcmtctftpptllzqllzflfrrgqgvgdvdfdbddprrrgccqvqnnmtmvmffpzzqggfbfnfwwqdqldqqlnqnttnbttrffnmmzwzjjtrjtrtmmqsmqmffqmfqfhhbthbhdhvdhvdvmvdmdhdshsqslldzztvvmzzdcccmbbhfhshrrrpsrrqqmdmmgdmmwdmdjdqqmcmttpgtgwgpwpprbrprhrsrllhsllprlplhppfzpffbhbccwdwbbrpbpvpqqmsspjssmbbmfmrmnrnwwgbwwbpwpjwwhqqgcqcvqccgffzpfftcffqlqjjznnlflhhlcczhzvhzhmzhmhfhnnqznntstwtggqjgjhggsvslltjlttfjjgffjzjwzzqzrrhlhzhbhphmhlmlzmzsmzmccvllgrrpbrbfbjfjttqjttdrdhhggqgddppqgpqgpgtptjptpllwccmwcmcpmcppdrrtstqqczqzvvlsltlddnvdvggcqqblqqsjqjttzhtzzszllqsqfqddqdbqddwqddfzzlczcscfsfpfdpdrpddsggcqchcfcpcssstwstwtggghvhqhzzqssjddwjwbjjsnjnfnwwglwwfnfhnnscsggzgjzzhzmmqfqsqwqrwqqqdtdcttzvvnbngbbcdbdggddnmddgzghhzgghwwbjbttlwlcctlccwwdhhrqrvrjjlglssgttpllwclwwtptwptwtvthtbhbzhbzhhrsrwwwnrwrfwfnwnhhnqqdjqjpqqwdwttzhttcdttvztzltzlzmzddrsdsfdsfftdfffmwffrjrffqrfqfsfqqqgqjggwzzrnnqfnqffdbfbtbbrpbrpbptpwttjmjjzrrhhqppdzdtdjttqwwtddjdzzmgzzhwwwdsdgssprsrgsgbbphhdpdwppnfppdqqwzzpbzzqwqpqsqhqdhqqtwwjnnmvmwvmmwwgjgzjjvcjcvcjcnjcncmmphmmvmwmwpwbbtbffhnhshgssgvgvrrbwbtbddqmqfqvvfqvqdvvdbvdbdcdfdlflmffrwwgmmttrztrrfrqrpqrrzjrjpjdpjprrnhhbhcbbcwwqlwwcssbddfrfjrfjfrjfjvvdmdtdzzlvzlzhzmhmhphchnnfqnffvccfpfbfpfqpprrmttzrzzjzmjmzjmmfvmmrzrqqdllgjlglcchssgllsbllrbrlrjlrrhhfwwsqwsstpssznzcznzqzssvtvtrrqwqvvtssgfsfhssljjnwjnjddjdggclcrrfsfhsstgtdtctfttvvsbvvbtbttcgcssjlslhlpljpppwzwnwdnngmgjjbzznwwdllrrfppshhvdhhldhdbbdbjbdjjrnjjzhzfhhsqqbqgmsbvnjsptlrsszlqfmgprvscphmqztbgtlrqvcgdzcptcqjncrdtfqnghnbmwwmcjgtjlbvqqzslgbbntrdfnvfjvfgcgngndjcspgwmpnsrqzzvzljbzlzzrwflrqqqmhsvqwbmdftnhwwzgqrlhddbbtwvbphljmstcjzvpjqwcnhlvpqvqdgvntgqzqwrlwbwvngwtqgrhznlzcvbwqmwncccjctrdzrmzjsvrmcfpjjcczhbvdfwhqvczggfmrspvprvvthvtqnsphpcsdmbrtbdqljvssdrhwjsrrlzprstpgqcbpmnpdgzgjttwcfrgjnsghmszlclgvmlsjrqfvflbnhwwphtvrnrbhdvdglcvgpzfsjpwwhtlvvdzthsrldfzhnlrblzsjjnwclqsqzgdbflhvpwcrtfbfbjcjttbjpvfgvfcswnqqwshbmqlscdzzwshfqwsvwnwzltbnrmzzhzvtwpzqcgwshpvzgtcmwrtrwctnpzbznnwqphnrgwljtrcwlqmvlndwrdrctztnmswslqmbjcmtlrmcpjvzccqszrnflqnqzttbhqlrhbmqdpscqvfgtdbnwjdcljwcbgbgjfzgrgpwqzqgbnrtpntfthhdbqmswvhnmwmszpghgjjzrbnbbfjblpstdfslmmmqfdcrhblqjqfphnldrvvfpnfrcvprjnqbzbspfpjtgqhnjbhnrwzcjvdbshhqpgrmzqpmjfmqwqvvdbddbsldwzzsrhnhsjjnvljrbwcnjrnjpmrrvfthftgptgtlpbgqffthflgftwcrqcqwqwrmrcmfrcqgmrnqjbscdcgrqlhjzthvzdgjbvpswflqcgsnlmgmvcsttsgmnqdtvwdvrndvfdcvrcwmqlmlhtrvthsndsrmnsfmdmfnpfmfhzjqmtcjzcrnsjdztztvgdtlrmbdmmstbfgpmmzthcslpvgrpgfljfgqlqhldfwvvvdvbzjtdtppbtrnqwsqztjrsjhtfrgmvsdngvsdzjgpwrldqpzdpvhljzpjvttwltdwcrhcbrgrvdrmpwvdwjchqsjfprbgtjtzggvgrgmlvvwqrjfprbbgjjqrtdfnrdffwbswbvqtqtfsrhsgrjhftqldhmcnmsnfflmdrzqdjmbqqgqsttdmtrrvfsjnccnhcpcvqtrzdjzrpwswmjvvgsgwvnmdgqwlctrlhqnsmczbwsjhmtgvdcgsndzlstcwchcztqqbtdwfvlljdvdlzljslgnzpmqvzfcvqhdzvgchffqgfwrnmwqzwgbzblpmvddlvnhglrhdnwzqwztzgjczjpwcjwmpnrnrhncfjfggrbphrjztwtfqmfjlwfhnqfftfghbnvtwgtmdzzrdrtmfrwhrrbhzmcllsgqzwzzqtgdggvzptvtdcpzmtmsfcfbjtzlbdrwhdbtdhhrgggmddnzsvjwgcdcqfppqwphfvlhmgqsznlhmgpnjvcvrwwppnphchgsrhjwjcpjggsrcwrvnllfgrmjltfzwhmbqwpwwzmrtlqcprrqztcgnghcbvzrbfptjmhtdcfhhffdbrswqpnpppnpqwtflrrmqgjzctmmvvvwzllbsfdvpqjtmvpjcpmjztscsgbdznfgcmtjzdqzwqrsvstnnvddcstzqjtnbsnlptpmbmfqmhppgnjrffqrtchgptbmwlwbwbcqqfngpbwtwdmlmdstmqwcwjtbwbbbhghgptmvhfmvqfvpwqzwnbjdhpwlgjgvprdjbnlzhnllssbpvzfzspwsscfpqtpdvtzvqncfrfrgddsdglqvpblmpcczlqfdmwzmgvrljhqtcglcvfhbdwhbttqqrjbqwhsrhrbjwmtqwqddvdggdwfsmnpbpvvgsqnvvrqntwmbzdnqpmmqtbnlsbmslpfmqjtgvbddhwvlvjtlrhqdpfnjwtbhwjwdrpgctbbrdqvbbnvgqwngrhqfvwzmlqtmhfqphnmczlbdpnbmpvwrsjbcnjnvcfgnsvlhpzdgdzgvfbgwdcrswznrggnghzssdwqvvlwftqhbnwdvghhvjlqqmcnqmvbwhrrnsswlwmwbsmpcpdzzgmcmqnzpvjpzqbwcsgdhqtqhcpbtqftvscmntsbdcbrndvlfhprpblzbjcpqhfljtvnvtgvrcgqbsgl
  """
  def put1, do: @p1
  def put2, do: @p2

end
