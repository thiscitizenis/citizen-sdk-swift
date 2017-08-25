// Enums for Swift lack the following properties of their Java counterparts:
//
//   * No support for multiple enumeration types pointing to the same value
//   * No straightforward method to iterate through all types
//
// With these constraints in mind, the design below was used to support the
// following functionality:
//
//   * Allowing multiple enumeration types to point to the same value
//   * Have methods to iterate all enumeration types and their values
//   * Set an enumeration type from a string
//   * Export enumeration type and value as strings
//
// This currently requires that the enumeration items be listed twice, but there
// is a compiler check in the 'description' variable to ensure that all cases
// are covered.
//
// This design is used in most of the enumerations here to ensure consistency.

public enum CountryCode : Int
{
    case AF = 0
    case AD = 1
    case AE = 2
    case AG = 3
    case AI = 4
    case AL = 5
    case AM = 6
    case AO = 7
    case AQ = 8
    case AR = 9
    case AS = 10
    case AT = 11
    case AU = 12
    case AW = 13
    case AX = 14
    case AZ = 15
    case BA = 16
    case BB = 17
    case BD = 18
    case BE = 19
    case BF = 20
    case BG = 21
    case BH = 22
    case BI = 23
    case BJ = 24
    case BL = 25
    case BM = 26
    case BN = 27
    case BO = 28
    case BQ = 29
    case BR = 30
    case BS = 31
    case BT = 32
    case BV = 33
    case BW = 34
    case BY = 35
    case BZ = 36
    case CA = 37
    case CC = 38
    case CD = 39
    case CF = 40
    case CG = 41
    case CH = 42
    case CI = 43
    case CK = 44
    case CL = 45
    case CM = 46
    case CN = 47
    case CO = 48
    case CR = 49
    case CU = 50
    case CV = 51
    case CW = 52
    case CX = 53
    case CY = 54
    case CZ = 55
    case DE = 56
    case DJ = 57
    case DK = 58
    case DM = 59
    case DO = 60
    case DZ = 61
    case EC = 62
    case EE = 63
    case EG = 64
    case EH = 65
    case ER = 66
    case ES = 67
    case ET = 68
    case FI = 69
    case FJ = 70
    case FK = 71
    case FM = 72
    case FO = 73
    case FR = 74
    case GA = 75
    case GB = 76
    case GD = 77
    case GE = 78
    case GF = 79
    case GG = 80
    case GH = 81
    case GI = 82
    case GL = 83
    case GM = 84
    case GN = 85
    case GP = 86
    case GQ = 87
    case GR = 88
    case GS = 89
    case GT = 90
    case GU = 91
    case GW = 92
    case GY = 93
    case HK = 94
    case HM = 95
    case HN = 96
    case HR = 97
    case HT = 98
    case HU = 99
    case ID = 100
    case IE = 101
    case IL = 102
    case IM = 103
    case IN = 104
    case IO = 105
    case IQ = 106
    case IR = 107
    case IS = 108
    case IT = 109
    case JE = 110
    case JM = 111
    case JO = 112
    case JP = 113
    case KE = 114
    case KG = 115
    case KH = 116
    case KI = 117
    case KM = 118
    case KN = 119
    case KP = 120
    case KR = 121
    case KW = 122
    case KY = 123
    case KZ = 124
    case LA = 125
    case LB = 126
    case LC = 127
    case LI = 128
    case LK = 129
    case LR = 130
    case LS = 131
    case LT = 132
    case LU = 133
    case LV = 134
    case LY = 135
    case MA = 136
    case MC = 137
    case MD = 138
    case ME = 139
    case MF = 140
    case MG = 141
    case MH = 142
    case MK = 143
    case ML = 144
    case MM = 145
    case MN = 146
    case MO = 147
    case MP = 148
    case MQ = 149
    case MR = 150
    case MS = 151
    case MT = 152
    case MU = 153
    case MV = 154
    case MW = 155
    case MX = 156
    case MY = 157
    case MZ = 158
    case NA = 159
    case NC = 160
    case NE = 161
    case NF = 162
    case NG = 163
    case NI = 164
    case NL = 165
    case NO = 166
    case NP = 167
    case NR = 168
    case NU = 169
    case NZ = 170
    case OM = 171
    case PA = 172
    case PE = 173
    case PF = 174
    case PG = 175
    case PH = 176
    case PK = 177
    case PL = 178
    case PM = 179
    case PN = 180
    case PR = 181
    case PS = 182
    case PT = 183
    case PW = 184
    case PY = 185
    case QA = 186
    case RE = 187
    case RO = 188
    case RS = 189
    case RU = 190
    case RW = 191
    case SA = 192
    case SB = 193
    case SC = 194
    case SD = 195
    case SE = 196
    case SG = 197
    case SH = 198
    case SI = 199
    case SJ = 200
    case SK = 201
    case SL = 202
    case SM = 203
    case SN = 204
    case SO = 205
    case SR = 206
    case SS = 207
    case ST = 208
    case SV = 209
    case SX = 210
    case SY = 211
    case SZ = 212
    case TC = 213
    case TD = 214
    case TF = 215
    case TG = 216
    case TH = 217
    case TJ = 218
    case TK = 219
    case TL = 220
    case TM = 221
    case TN = 222
    case TO = 223
    case TR = 224
    case TT = 225
    case TV = 226
    case TW = 227
    case TZ = 228
    case UA = 229
    case UG = 230
    case UM = 231
    case US = 232
    case UY = 233
    case UZ = 234
    case VA = 235
    case VC = 236
    case VE = 237
    case VG = 238
    case VI = 239
    case VN = 240
    case VU = 241
    case WF = 242
    case WS = 243
    case YE = 244
    case YT = 245
    case ZA = 246
    case ZM = 247
    case ZW = 248
    
    public var description: String {
        switch self {
            case .AF: return "93"
            case .AD: return "376"
            case .AE: return "971"
            case .AG: return "1268"
            case .AI: return "1264"
            case .AL: return "355"
            case .AM: return "374"
            case .AO: return "244"
            case .AQ: return "672"
            case .AR: return "54"
            case .AS: return "1684"
            case .AT: return "43"
            case .AU: return "61"
            case .AW: return "297"
            case .AX: return "35818"
            case .AZ: return "994"
            case .BA: return "387"
            case .BB: return "1264"
            case .BD: return "880"
            case .BE: return "32"
            case .BF: return "226"
            case .BG: return "359"
            case .BH: return "973"
            case .BI: return "257"
            case .BJ: return "229"
            case .BL: return "590"
            case .BM: return "1441"
            case .BN: return "673"
            case .BO: return "591"
            case .BQ: return "599"
            case .BR: return "55"
            case .BS: return "1242"
            case .BT: return "975"
            case .BV: return "47"
            case .BW: return "267"
            case .BY: return "375"
            case .BZ: return "501"
            case .CA: return "1"
            case .CC: return "61"
            case .CD: return "243"
            case .CF: return "236"
            case .CG: return "242"
            case .CH: return "41"
            case .CI: return "225"
            case .CK: return "682"
            case .CL: return "56"
            case .CM: return "237"
            case .CN: return "86"
            case .CO: return "57"
            case .CR: return "506"
            case .CU: return "53"
            case .CV: return "238"
            case .CW: return "599"
            case .CX: return "61"
            case .CY: return "357"
            case .CZ: return "420"
            case .DE: return "49"
            case .DJ: return "253"
            case .DK: return "45"
            case .DM: return "1767"
            case .DO: return "1809"
            case .DZ: return "213"
            case .EC: return "593"
            case .EE: return "372"
            case .EG: return "20"
            case .EH: return "212"
            case .ER: return "291"
            case .ES: return "34"
            case .ET: return "251"
            case .FI: return "358"
            case .FJ: return "679"
            case .FK: return "500"
            case .FM: return "691"
            case .FO: return "298"
            case .FR: return "33"
            case .GA: return "241"
            case .GB: return "44"
            case .GD: return "1473"
            case .GE: return "995"
            case .GF: return "594"
            case .GG: return "44"
            case .GH: return "233"
            case .GI: return "350"
            case .GL: return "299"
            case .GM: return "220"
            case .GN: return "224"
            case .GP: return "590"
            case .GQ: return "240"
            case .GR: return "30"
            case .GS: return "995"
            case .GT: return "502"
            case .GU: return "1671"
            case .GW: return "245"
            case .GY: return "592"
            case .HK: return "852"
            case .HM: return "null"
            case .HN: return "504"
            case .HR: return "385"
            case .HT: return "509"
            case .HU: return "36"
            case .ID: return "62"
            case .IE: return "353"
            case .IL: return "972"
            case .IM: return "44"
            case .IN: return "91"
            case .IO: return "249"
            case .IQ: return "964"
            case .IR: return "98"
            case .IS: return "354"
            case .IT: return "39"
            case .JE: return "44"
            case .JM: return "1876"
            case .JO: return "962"
            case .JP: return "81"
            case .KE: return "254"
            case .KG: return "996"
            case .KH: return "855"
            case .KI: return "686"
            case .KM: return "269"
            case .KN: return "1869"
            case .KP: return "850"
            case .KR: return "82"
            case .KW: return "965"
            case .KY: return "1345"
            case .KZ: return "7"
            case .LA: return "856"
            case .LB: return "961"
            case .LC: return "1758"
            case .LI: return "423"
            case .LK: return "94"
            case .LR: return "231"
            case .LS: return "266"
            case .LT: return "370"
            case .LU: return "352"
            case .LV: return "371"
            case .LY: return "218"
            case .MA: return "212"
            case .MC: return "377"
            case .MD: return "373"
            case .ME: return "382"
            case .MF: return "1599"
            case .MG: return "261"
            case .MH: return "692"
            case .MK: return "389"
            case .ML: return "223"
            case .MM: return "95"
            case .MN: return "976"
            case .MO: return "853"
            case .MP: return "1670"
            case .MQ: return "596"
            case .MR: return "222"
            case .MS: return "1664"
            case .MT: return "356"
            case .MU: return "230"
            case .MV: return "960"
            case .MW: return "265"
            case .MX: return "52"
            case .MY: return "60"
            case .MZ: return "258"
            case .NA: return "264"
            case .NC: return "687"
            case .NE: return "227"
            case .NF: return "1"
            case .NG: return "234"
            case .NI: return "505"
            case .NL: return "31"
            case .NO: return "47"
            case .NP: return "977"
            case .NR: return "674"
            case .NU: return "683"
            case .NZ: return "64"
            case .OM: return "968"
            case .PA: return "507"
            case .PE: return "51"
            case .PF: return "689"
            case .PG: return "675"
            case .PH: return "63"
            case .PK: return "92"
            case .PL: return "48"
            case .PM: return "508"
            case .PN: return "870"
            case .PR: return "1"
            case .PS: return "970"
            case .PT: return "351"
            case .PW: return "680"
            case .PY: return "595"
            case .QA: return "974"
            case .RE: return "262"
            case .RO: return "40"
            case .RS: return "381"
            case .RU: return "7"
            case .RW: return "250"
            case .SA: return "966"
            case .SB: return "677"
            case .SC: return "248"
            case .SD: return "249"
            case .SE: return "46"
            case .SG: return "65"
            case .SH: return "290"
            case .SI: return "386"
            case .SJ: return "47"
            case .SK: return "421"
            case .SL: return "232"
            case .SM: return "378"
            case .SN: return "221"
            case .SO: return "252"
            case .SR: return "597"
            case .SS: return "249"
            case .ST: return "239"
            case .SV: return "503"
            case .SX: return "1"
            case .SY: return "963"
            case .SZ: return "268"
            case .TC: return "1649"
            case .TD: return "235"
            case .TF: return "262"
            case .TG: return "228"
            case .TH: return "66"
            case .TJ: return "992"
            case .TK: return "690"
            case .TL: return "670"
            case .TM: return "993"
            case .TN: return "216"
            case .TO: return "676"
            case .TR: return "90"
            case .TT: return "1868"
            case .TV: return "688"
            case .TW: return "886"
            case .TZ: return "255"
            case .UA: return "380"
            case .UG: return "256"
            case .UM: return "1"
            case .US: return "1"
            case .UY: return "598"
            case .UZ: return "998"
            case .VA: return "39"
            case .VC: return "1784"
            case .VE: return "58"
            case .VG: return "1284"
            case .VI: return "1340"
            case .VN: return "84"
            case .VU: return "678"
            case .WF: return "681"
            case .WS: return "685"
            case .YE: return "967"
            case .YT: return "262"
            case .ZA: return "27"
            case .ZM: return "260"
            case .ZW: return "263"
        }
    }
    
    public static func fromString(constant: String) -> CountryCode? {
        var i = 0
        while let enumItem = CountryCode(rawValue: i) {
            if String(describing: enumItem) == constant {
                return enumItem
            }
            i = i + 1
        }
        
        return nil
    }
    
    public static func fromOptionalString(constant: String?) -> CountryCode? {
        if constant == nil {
            return nil
        }
        
        var i = 0
        while let enumItem = CountryCode(rawValue: i) {
            if String(describing: enumItem) == constant! {
                return enumItem
            }
            i = i + 1
        }
        
        return nil
    }

    
    public func toString() -> String {
        return String(describing: self)
    }
    
    public static func allItems() -> [String] {
        var enumItems = [String]()
        var i = 0
        
        while let enumItem = CountryCode(rawValue: i) {
            enumItems.append(String(describing: enumItem))
            i = i + 1
        }
        
        return enumItems
    }
    
    public static func allDescriptions() -> [String] {
        var enumDescriptions = [String]()
        var i = 0
        
        while let enumItem = CountryCode(rawValue: i) {
            enumDescriptions.append(enumItem.description)
            i = i + 1
        }
        
        return enumDescriptions
    }
}
