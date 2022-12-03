defmodule D3 do
  def run1 do
    backpack = String.split(In.put2)
    |> Enum.map(fn(x) -> String.split_at(x, div(String.length(x), 2)) end)
    |> Enum.map(fn({x,y}) -> {String.to_charlist(x), String.to_charlist(y)} end)

    find_common(backpack, [])
    |> count_value(0)

  end

  def run2 do
    backpack = String.split(In.put2)
    |> Enum.map(&(String.to_charlist(&1)))
    |> Enum.chunk_every(3)
    match_commons(backpack, [])
    |> count_value(0)
  end

  # part 2
  def match_commons([], c), do: c
  def match_commons([[x,y,z]|rest], c) do
    cs = find_commons(x,y,[])
    c = [match_common(z,cs)|c]
    match_commons(rest, c)
  end
  def find_commons([], _, cs), do: cs
  def find_commons([h|t], y, cs) do
    if match(h, y) do
      find_commons(t, y, [h|cs])
    else
      find_commons(t, y, cs)
    end
  end
  # part 1
  def find_common([], c), do: c
  def find_common([{x,y}|rest], c) do
    c = [match_common(x,y)|c]
    find_common(rest, c)
  end

  def match_common([],_), do: :error
  def match_common([h|t], y) do
    if match(h,y) do
      h
    else
      match_common(t, y)
    end
  end

  def match(h, [h|t]), do: true
  def match(_, []), do: false
  def match(h, [_|t]) do
    match(h, t)
  end

  def count_value([], sum), do: sum
  def count_value([h|t], sum) do
    val = h - 64
    if val > 32 do
      sum = sum + (val - 32)
      count_value(t, sum)
    else
      sum = sum + (val + 26)
      count_value(t, sum)
    end
  end

end

defmodule In do
  @p1 """
  vJrwpWtwJgWrhcsFMMfFFhFp
  jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
  PmmdzqPrVvPwwTWBwg
  wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
  ttgJtRGJQctTZtZT
  CrZsJsPPZsGzwwsLwLmpwMDw
  """
  @p2 """
  WjmsdnddnmQPZPPJPL
  bQllTtpBlgwtrbbCwfZcfSFPSfLCSF
  GgVgQrlpphBGrlVGgTtsRHRWVRMzRdVsqdnDnV
  MMTcbpnfNGQbMjgsRwSzRptRzz
  lPqCCqQdQqQmCPRzRVSwtzgqqwqR
  lrDdllPdBWdDFQFnMbDNDn
  FldWTldlpBSLzvpnpSTpWbDhbHNDPHhJcNHNDwbH
  qVCGQRGrrgMQrJhPNchgvgJhNc
  frjGfMrGQMjsRrRQjvQGmrQQszTTpSLBznlzBlLLSBLLSZTn
  TPZZZMTTbNTZNtTlTbjPVRVGzpGQLLzdGgmslhzSzgLzQh
  wrfwDDvcnFvCfrrSQsmzGGQQdndsGg
  qfHwHCqCqCrFJrcBHCCJRmWTRTmVMttjRjRHZMNV
  vpbqnzbPmWLFjFLBnjZg
  NltQcCClQlcGQGtMTCRdGTGBFZRLZjFFZZhBPLrFHZFjHf
  lMtlGMwMsCCNlTwtsCPzzmPmmVpmpWqVWsWz
  VmWVSchSrScGtwlVtBnwBVFF
  RZZPRNpPCLZvZPZNCLbQPZNBFtttmwBMTMTtttCwtgwBgl
  RNNmPvbQQjPRQQNNHpNbhsfzWJqqSJcsGHhHcfhq
  dtJvcpccWvLDztRCRRCrCC
  qHVslPzPqHqzmPhTzmDFggjrHrSCNFFFSjgR
  qPVPMhszZPVhwBZcdpvZJncbcJ
  HBNLlBDtvLDHhHLvfwlFjqfQTFqqWfST
  ddsGcggJncZVRdGCdZdcWWzSFrjzQFrfTzqfCjFw
  VdgscZmbZNBvbDHTbL
  GtSZQqpHpHfGHzzqHzHfSbPbnJCrRCnJChmjnJnbSh
  DvcTNTDWlNDWdlbnnbjmRhRrCCRd
  cclNlwBRvvTNccRlBNRspVLLZzVzVZQqfqqLpzpw
  dBSfHdZvMQMdNVpWRmWmLCmmtB
  rbTTrrjDcqcrrqrjjJGGclltPCWDmvtpmpPpvRDsCspsLC
  vlhjThlqcjrnTvThndddHZngMnfwNQFNFM
  tHqfszrgLsvgqtHrHtwVCGBRRjGSCwsCsmmV
  MdFMclPmcDQFDlDdlZPmbVpCbFpCbBSCCRGCFpbV
  mcDJdDQMcDTZQhhNNPldhhDtvHLgqtzgLvzTzWHWnWfvvz
  sVdGlTMMVTGCdsTMHHWWnNBzNWpNWCpW
  mPmjFhlwmwmWrpSrSWHB
  jhPhjwgthtFFjRwjZgjGdJcdflfqMsZLLsdZdc
  CBRsTsBBzLCfLqtqBRPNDQglSttlcgDlgGGt
  rJdbrJjrdbVJZdVZCGrNNcgDQlcQrggl
  FpFbbppjFCdwmTvsvfzmTnTBfq
  cqhcWqqCNjGWqcqhGGZzngftmptLZLGZTn
  brJHBbPVHPvSsdHrzQLzZgpfVzpfQtnL
  dHFPBPrBJFRzcWNFhWwN
  QTBTfQTZsjWDJBJd
  FgFWNqWGDPqlPllp
  CCvHzSWFrrtvNvNNHLGQQfbVRRfHZcZcVTTTnZ
  ZCCHHCVRZzBZQThM
  nljDtcqnhcfbwjwltfLQMLLQQppJBMLQJL
  qDsqschsqblDqjcqtRmNVVdNsddNNPmFgV
  QQRnqGBSpQnMmSGmRQQFtdcbbtHHccjpTFcTfF
  wCNPNwNNWNgZHJHJFffqCjbj
  ZNPzNWgNrsmzMVqsqs
  pVWlMBWjlWWqspWDjdjMpMDCPtmmdbhtQtQtbGPCzChchz
  HZNgrHSvHwnFZnvgNvnwLPBGQHmCmtPmtBCGGCmQhG
  FrNfvSNSZLZJrJsVlRWWWqRBVTff
  PQctSHQDPSQcbShpFzbmFddpmdmR
  wqWVwvwNCJRhmdhwJw
  nMnWggVqRVZqHBSBsQsQGDSZ
  qppwrgZSLsVbbfvZ
  hhBHPQQChCDcPcsvvhbGbsllJTfv
  MDWmWFCPFWtgpRWjws
  bmRjdmrJRjhJdJLZBjTFfHGTtQFTSQBS
  wCNVnsspwsnvNDwnsDwSBHtDHHQGTFQFtMrQMS
  nWsNvqVgVcqdJrchrz
  MZlfqlmblmMRWhWNsjSQfh
  CznczgtDFnVtFBNSRNttvhQsNh
  SGDFzVrzVPrGHVnzCPVnlZlPwTbpTqlbqLMpbLlq
  lbbbGDlwLDLjvDvm
  FQfQnLTWVcPChtjmjWSj
  cfgzzgfgfVdzTdfNwBpbLbwdRbpZGrdw
  mwnWtbmdWdccwtgTmwnQfPqsqLQQJQQLsfQQ
  SjrZbhvBZzPHQqfGJfjG
  FlrMBSvMZZFBZhShMMdctWDtmFNDbDTmtmpt
  ndHWprpqFTnnpdNFlhljzlGTwDGzlhGz
  fvZmmVVfJctMZsgMgmcBmsZhwQlGDCzPPZWDGDjCllhC
  WsmvmsmRNnpRHdbS
  LgZSvhvcsWtcWnjrFrWjjjnPWW
  DJDfNlDNRFlpMlFLFP
  TmqTqDHdmfwJRwfdQJLHzzSggHZZcGzhtZvcZhzG
  lbTpqhhgSlgtlTqSDzzLPPPrLGTTGnLm
  VwGfQGBGZWNnmDLPznLB
  vQdfZFWvFMMFwWGGhpGqJbpFtgbS
  hSvCvFRDwmzCCHrszb
  jdMgfTblgjJTLLLzqqGscmPmlqPzHc
  bjQLTTbZMfJffZBBWdjBBQwVDntFpRvvDVvSnhppFv
  FFnFQndPqzmjHscmJFwc
  ZrZrRgDphGGDZgRRBSBNMHHvmwJJSNJHcv
  DGrbbthfWWWDgtfffttfpGPVqnmblqPqCdQTlTPCzTll
  sHTsGrHpsftmddRRZfRv
  MqFcqcMQbMcVPCdFZCzZsRsFzL
  qnVlBbcJJbbMcbgQJMMbQlDWWwHWSWwpTsGHGrpDWG
  qpmvVVcGvVVcVmDsCfqTHLLJzTjfZzLZ
  rSSgwwnSRRBrQrZzZHCQrZ
  BFgFRgdNnSBbbnhSMBSNFdsWVtpWmzsGtvpVPvGWVDDN
  fBBRfJBzzMRGRzCBgWtbCWtbgHHHWdqt
  mvNcDcsDLLnnqfbv
  hpTsTsTrDrfpMSFFZjPFMrSP
  CNQGGDMFWGnWWvvNMQFPvrgzBLVBLszwgggLgw
  mppZVZtZRTbTTpRccVbgrSLzSPSzBrfbPBbSPw
  VtZJhRJcTpJTHlhtHZCFFWFjNjGGnFhCqDqG
  cppcZGcGgGpdTgSSnmpFMFrFzmwqwmrHwz
  RStQJNCNvfBQNjrqmrjFrBMzFB
  LJDNNJCDLcdLnSVd
  gNrBNSrNNtSjBndzmzlVnm
  MbfqfpCLpCsLqsLFSbQLfnMdcdRRcdzldlnljzncnJ
  QPQLqZqhSqhvtvTTWrNg
  DtrrcGvtLnrrvLrfctfHztrfQpbwwphpdSbbPPPwFSFFRPwH
  gggBqTNdTNjqWBlNmCqCmNggQPhpPPPbhhQpSBpJwbSJSQFR
  ZglTmgWNgVZMZdsGMcvDcMdMnz
  bjtTFsPmmtpvVlQHlQJQnJjn
  WzDzwLCSLrrDNLdrSZRCwNzrlQlJMnJQJJVhbcMhgllwnJQh
  fRCZzrWRzzGbGvTmBPTf
  lVlfJVblPQbllflfLdJdvGpjnFRFqJFnDqpJjnpF
  HcwZMgmwWCHHCSwcWCcgSCtCqqpFppGDqvDnRhgnnqFDpjFT
  cwCHtGrCssWHCCWZZMbPPNBVbNfVbPllVszf
  DSpSnRwrZDPWsJdZ
  zjjlQVjlNZmCVCfhCfgFFfFFFqWJbgbFWHJH
  lNQMlGjQBZjCmhNMCChGzlVNrpTnccLLwcRwTSppSpprLRcB
  vLfvcgglbfLfgqdgNpPtzqDmPzmJTTztPCHT
  ZWSQVGwQcWjSshGwVcnSzDJZtPPTzmzzJHCTzDtJ
  SjVSrWVhQVQhwrLMcrFbfplcflvv
  NgtfSRPnnRrSlgsPhnShDWQlMWpVBMMMpCWVBpCQBB
  LLJnvwJvZHZbHTbVCQBppCFJCWWQBz
  wHTGZmZvdvLvjLwZdqngNgsGtrDPSDhtNfDf
  DwrDRlrwmbSbRgwsSbRwGJvQGqjJqGNTJTNGTSGn
  PZdMZzCQFBZWWFQvJZvcNcjqNjjZJG
  WHWCFHBBdzzMWhPFtFdMzlRsVbVmDrRVVrtQplwVwD
  bpWbJMWpJbprfNMrBfJfprWhPnGtnHnLHjPPjLvsWnHGvGvj
  qZdgVVgDQhQZlwcqgDcchldjjmLtntmntPQsmLnLPjssnL
  RVRlgcSSdglZczdqbTCrhBrBpNBSBSbF
  SgbGvfbnGgmnNnnzqMqqHHRzbZBzZR
  TWlssdFwWdtswWPtTtWltwdVHlZZzRHZBZRzrprqHMpqgZrq
  dssdCWTFwSvgmDjDCG
  pqsDnNzzZsdZSnDSpwjBCBWvgjvWjNFWQgWC
  lVGtRtLMGGfbTGTtTbQCQnBQBnBFgFQcgjfc
  GPbTbPtnPttmLTGRRbtmdwSDwpwwhZqmdpzDhDJd
  MdccRQMJvHdgZggvhjjMgHcHlWWqFFWmGqFbJWzzFLWlLmPm
  TDpSsTrtblSzQlGQ
  tfVNrwTwtswTssMRjMMQQddNMRCd
  GqGqGpFqqgDGFRqDwwqqmzpGTLPvVWMPVCPLJLRJJMLTlCWV
  rHrSbrsbQcbtdNHHHfdPlvWBLLWlvMTVlVLCJf
  rccbtthHSHsNHrrcttwqpnDFnMmpnzFnFhnF
  vQQQbRvlLjNNLLBzNllNHNBqGqhMWhGGhTqmPmqhWTFhRm
  tnsZwgSnCDrZSCDsfTMSGpPWmPSWmGmbFq
  CrVnfnCCtrCgfrffcrstDnJNlvJdNvzdBcHdLBJHvbBv
  nmQsMqTnLlmmpQZmTZcdHwCFSpHJSSWHSJVSWSHH
  vRgRRtfPvDjzDgDbsjzRvjfNNWWCSJFwrHCFbrCJWJHCSC
  GhsRBztDBgzRPstgzBLZcqmlcLMMlmdLQBZT
  CWfvvhfWrlllSSRrdQrQDQGQdTRr
  jsNctMZLmMZLMmmmbbNZswZNqBTHPHzBMHHTMGqBRMRPDQqP
  jcwjntLngngplgFhgRvJVp
  vchzqzwlhzRqzVZQwqtVPZLnLLbDnDFnbGLnDbPLDGWD
  pBTHpdpHsrNBBsgdrdCpCpCgRFCMFDLFWWnFWLRRGWbDFGSF
  prsBHfggjpjjcRQlqvtw
  VDwzLQrDDWrrwWbJrVJwVrVQfMfSCNPMfSlMlPcMmThChf
  tsjFdsRsgtRmGZHpHRgBClSlGSClcPhGCfPlllll
  qBBFBZZpmgdFHdstjFJbzVwJVqJWWbrvWJDL
  mgjZmrqmdsmGtDplglJgRVVc
  nPhnLvnHLtLnWzzcNwwcchVJRflhpc
  SnnLntLWZsMqZrSZ
  jcrNfnrNLNNqFgbDfCSgSQbS
  zPPHtMrGGptvTWPVvzvHRgQsbDsSRRCCQbtJsJDS
  wHzrWVzPwThGGwMHzTGGPGwhdlZnBndZLljNjBcLdZdNBN
  qNPhNqddBNhqvPhFvllNgNBHCrrCQnjpCfPVJnnJQJCjJj
  ZZbZTZcmGWWMDWRSDnBVQCjVDffJjnnVCJ
  SGBRTTZGGcLSSWTScsmcMbGlhgwFqslhzqggghwhNvwwvw
  GCCPwpsBqNSsBPpSCrSshzQzLhTvQhqTnhtTVQcT
  JDjFJfMJgWbWWlDJcnvvhvtdLnjnzhjz
  FlDflbZfZgJgMgbmgZJfSpGCvvrGrRCpCBrZRprw
  HwqhgFGSMgPPCGQQQnvvcpjn
  BllbdfRBsBmsmZlBTmQCjTnNWNCmNmvc
  lJDlBflDdbbRlLbfsbZBJtbRqrVFPnwwwhVMHwVrgJwwrSwH
  LTvLtTFLCddFTTthsbVVmHHcqVHmWRcmHL
  lBgwwNggwMwNVbjBCQcCqCRB
  nCMCwZGGNGJnGhtrzsdDDndtsF
  ZlZdJJplLZBDpJjNJlGjQCLmCQmTwVVCbQQbqWCT
  SfgFzftrnRzMnVbPPPQmPq
  FfmrRvgShchvFfghzRvgtvFBpJDpcGNGdBHJlpDDDJlDJZ
  LdNrLzjdWQnrDHsD
  tBZmBZtVZpldVMPRnsRQsnnsHVbRHs
  MlfldwMBBFMZTSFTSqLqcvSJ
  nJqBlvvBjHhBcqqRrGPrTrGpBCGzTG
  MfVCVMLZVZtQCdtLMtQtQSSSTSzFRSRPFpFRGpdTFd
  CCQQtQVgfbbQNggsNfQZZbHbcWmnhlhnvlnlHjJWvnhv
  SGmmGwVwnmhbhnhwhhwbdMgNNgjmvMDrJTCgmBTBBj
  ztFWcWQQfcRzzRFllvjDjggjDDfBgJMBgC
  QtzcJtFtqcFQRRWRRQWFzFGpVnVSGLLGZVGVqddbLqGL
  tBmdmQtjMMqDLqBtttQMjDdwwgwccMMbffllgzncwfFflF
  TPVHTVsRsJVHVrVvHvrRhVJbfCgFbzwbCGgFlwgcCwbn
  hssVWnRrTVZSSZZqjLddWtLBddqtQL
  WhhtGZtZGQZmvCfCwtvhqgbfdDJdfjlSDlSlBBJDSg
  rHnpFHnDrdBggJngnL
  HVcTzFPNzTpPPVrzmtwtvvvmNQwDQvWw
  dStBwStGGBrNnBdrSSMzvjhgFcvvDcnnvPDn
  RLZbCWWJbHRsTHspZWLcDWcPPhzczfjgPjjvjz
  ZmLHJqJsLJJHLRsmmmGSztQdQzmNBrBN
  JrmRVdvcmvvmvvRTdBVVfjFQLwjqLFLWFMqwcFjz
  DDhhttDHHHbHSnsDbHqMqzwQLLFwLsjjLLQf
  bSbPthtgGQPNPHnSDChCRJZZJRCZdCrCBZZZZvJd
  rqvVqNJpVVNwnqqTwthMMq
  jsFRFDQRLQDQmsPRmQsmcQFMzGhwBGBhTzTTzHnRhnhBhRwz
  dCccQcQsFCmCQfbJbvZMNZfJrJll
  TGjrrTRLHvrQrFDCrmzzVm
  NwWqqhndWtzDQhCzVCsh
  CSSwNNwqgBBBBbGGvLTTvb
  fRBRBHCVRRzcCdZHvRvZVCZLNjtwtNwNTtLjNtTpTNttfS
  DZshMssZmTMjwjSLtw
  QPrJDDJsPDFmFrFDscHHRzrcvccCZRVzrR
  zgqzLLvlvdgpgrWpWW
  RnJmNRncnScFmZSScrJQQdbpGdHbWHtPHpBHsdFdsW
  JDfRcrSnmDSJcNfrNZNjvlwjhllhMzlDqMqMvh
  fDLzSMLhhtDWMvtjCRRZjCHHJjChHN
  pmTNpVwPNbPwPBFRqRJqjCnFjZFV
  dTwpddsTbgbQBssprsgtvgcNLzWMctfSgcfWLt
  fbBsBTsNDhGBGZcLLLJJQffQLQ
  MpsCCMHClsHQqZcQWLqR
  FtjdCFzVljFlslVCpFrFjPhggBGDgNSTTgbGNmbGTr
  HqTfmsCFmPlGHddNVGpLhz
  JjjcQQJgjZvZZzzwgpNVGwLGgV
  nQnSbDDRbSQJQQpRZtZcZZsPPrFfWCPFWlrFsFPqmqFt
  TgTDDrCmqJDGLrhqLmLGqDQRFtttjMbQZJjtdtjFdsdF
  WHffcHWnlvvcSSWzPVvHpWWVRbFdQQtQnjwZFMwZtwddsZbd
  cBpPplVVPfvVGBDLGCBqmmLM
  dlMMmnmjvCCjJrrvMdgHcbcFbqFbzQrFbGzb
  tPhRBRZPtZRshTzRsNShRZNGDfGgFFbFQqbGHDHbqfGD
  TSPhBVsTwRBTpVtRZpVhZLJjWzLjJlJlJvmwWWzwWn
  WcvLLgLcczLTDtccbLcgzMMfPsGwRPjwfMwHMfMvMp
  QVmlPQCdJlJJJlFJJJnPQQhlwwMMMnMwNMpwMGwwfswwGMsR
  lrSCZZVFhPSZgzgWttWBcc
  bwbbZLlbwlJhBzFCgtTGRGQldQRmQW
  SSnpHnPHqpmggCWgdT
  PPscHHTfcsPSDVfVssjvwFJLBJFjFJJZFJLNLwrL
  nLgDSHgwRgGnHjjNfTRhjPVpWV
  BstQsvhQZQQbMvCvMPVNWpPcTjfmPmmW
  brtCrtvtzrhdSDJDwh
  dTQTwgmZQbDzzMQCCl
  WLLtntFnfnRHbttnSRRzSMVGDDMGzVlV
  JsPhFtfbLWnsLPLqgdJcjmcwTwjcdw
  wMwMbMRRBBMLPBlhLRQlhPcWzgJNvJtzWNtJptpgjJgpBj
  TnmGGmVnFFNSZsnZqFsWzWjrTJzvzWvWgWtTWz
  qnHGnVSsqZCddnGCGCSNdDbLQPcLLQlDhPRMhb
  NGsBTBlqsvfQBQqsTLTFltRMmRwmmHmFtPSRhM
  gjZWJWCZdDpjggDdgnpWdZZJtFwFRFFRMwbbmRPtShnwRbtt
  zZpSDDgpzcDddjVWggJsQGrfQvrQcTGTGrTrqr
  hpJchhFWMpRDWHWcDGnCGrnGnwPTwpQnCt
  bmgddgmlmjjbfddgmmmNvGQLrtfTwrTtLtGTLQVQQP
  qqbmdZgzZbvgPDccHcZPhWWH
  VVrdQZZrZSZFgQTTTzggrVZVMlfBBfvcMBCBslMhBvsMBSff
  bQwnHwbNpwcsCwjMBw
  pHqqPnJHqpPNJFzqTzQWWDQQZq
  HgwTDfgBwBgcRHqRRjHqHTzQQClSzvlzPVSQLvbbPC
  MnhtNZNnJpWpGhMQbCCPVSPLNmSPQQ
  rrhJMFJJZFJpHcjRLFRfHjgj
  vGvGMBlttBltvjdgbPsrsDWdjPPP
  HnJQHVqNmQHmZsDZPPrDWpgFps
  JSqJQVVDqqVfJNfRffGSGMBwGTCCCTlBMSBl
  PsFZPfGbDNbtQmCCmCBBbmmL
  dcRdhSrCqjThTRcTpLzHQzTmpmlgBz
  hhhcqCvwhhVhfPNvsMstZtsZ
  VvGwBBwvZtGgfZCqShnFFjSstCMC
  NlTRdvpDdTRNzdTHHnMssCnCnCqjSz
  LvWvPcWLpGwBwVVgVc
  bVVmSrLmLSJzTZMSFTBdMj
  QnvqRGGDvWpQWGDpvsRZLBzTRjBTtjRTPtBF
  QWGvDpqcvpGWQpGngqGQGwpLhJVNJcrbfrVbfbhHrmlVJHVV
  NGRGPZWZpblGcJtfssSSsbffCs
  gwRhjvrgjmwgnzvJJJtVCtHJqs
  rrmLrhwFFmmTMgFRjNZWNpZlZLppQNcDWP
  qsHZsHZrTBtZrHBNFCJGWrMcpcddWGJWLG
  mRDDzbPVDVlVDgbgRRvmwCcWdGvJwGddpvLm
  PnfDbPbVzDbVfjnnlbzhVFsspBSfFsssHQNTBpFqNQ
  gCmtbDqPVVVqggCGqTJjHMpMQfgMpMHQQpcM
  zNZnsSLzZzrlRhTTJMHppjfHSpvp
  nhdrBsLlRRrdTlsTVmCmGqDVFdtDPGwV
  FnqNfdGfgzmPLGmj
  blvVvbsRwgnzjCPcbT
  RWWvtvphnZQZwMBNdHfNDBZZdq
  DMRhDhdvnjhnPnvPMfdZSGTccGJFjGFFpFpFTbTpTW
  NVgVmtzVlLBmgztsBNmtgCmqFpJJFGGpGbrcGGsrcpbWPr
  zwBztLBzllQPDZvfQZfRfHSR
  mFCgPzmqgtPPqMmFWzbMttcRGvRclvHhWGGcZvclRfHh
  psSNnhnLGnwZHZGv
  hBpNLTNLBhsPmbCgBtPDbM
  JsbLLWLJRfQFnccmQhtvvPCP
  dwgrVwGpgVhCrrhPDHtC
  gpGSjpVdVpVppjjVZBwdCbFRWLzLMSRMbNzfzbWR
  DmMQMJmnmGwzGwwG
  ZcLcgLgcRsZSctHFWLGfjjBwvbvBsvjpfhGb
  GgFPqFtLRHLFSHLRRFRHHtMnJVNCQCrJCJCnMJDdnqDV
  tqdqFqdsRdVdtHMNdRZHTZLrHJgrlZQPJLgr
  GGwVcpGznmhbWhwcVVgzTrDrDDLZlTLLZQrJ
  nhbnbfjcnfMfFNVtBq
  QHmPNZvfCLsSwJSm
  pDhjpVDFcRBpFFjjMnRcVhpFCzbzsZbSSCtwtLMSLZLLtLbs
  FRjrnRchnfHPrrZlHl
  bjjMbdChgRDZthpQpRQnwRTprRwS
  mGzJsGsHzHGPvvvqvzGzSnglSJrrwQgnlQQSrlQl
  qvzHqHLHmHgPsNBdCdZtVBtVVMBFbh
  CctrCwrdpTwcpVrdpTpcrcnSJQttvQPHJQNQnQNjvvHQ
  zsqRlslRLqfgRmWsRgRzqzQnHjSBSQWJHPhHnSvHnJJJ
  GRgllbgfRgbzfRmwwcGdFMcTVPrFCF
  """
  def put1, do: @p1
  def put2, do: @p2

end
