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

public enum CountryName : Int
{
    case AF = 0
    case AL = 1
    case DZ = 2
    case AS = 3
    case AD = 4
    case AO = 5
    case AI = 6
    case AQ = 7
    case AG = 8
    case AR = 9
    case AM = 10
    case AW = 11
    case AU = 12
    case AT = 13
    case AZ = 14
    case BS = 15
    case BH = 16
    case BD = 17
    case BB = 18
    case BY = 19
    case BE = 20
    case BZ = 21
    case BJ = 22
    case BM = 23
    case BT = 24
    case BO = 25
    case BQ = 26
    case BA = 27
    case BW = 28
    case BV = 29
    case BR = 30
    case IO = 31
    case VG = 32
    case BN = 33
    case BG = 34
    case BF = 35
    case BI = 36
    case KH = 37
    case CM = 38
    case CA = 39
    case CV = 40
    case KY = 41
    case CF = 42
    case TD = 43
    case CL = 44
    case CN = 45
    case CX = 46
    case CC = 47
    case CO = 48
    case KM = 49
    case CG = 50
    case CK = 51
    case CR = 52
    case HR = 53
    case CU = 54
    case CW = 55
    case CY = 56
    case CZ = 57
    case CI = 58
    case DK = 59
    case DJ = 60
    case DM = 61
    case DO = 62
    case EC = 63
    case EG = 64
    case SV = 65
    case GQ = 66
    case ER = 67
    case EE = 68
    case ET = 69
    case FK = 70
    case FO = 71
    case FJ = 72
    case FI = 73
    case FR = 74
    case GF = 75
    case PF = 76
    case TF = 77
    case GA = 78
    case GM = 79
    case GE = 80
    case DE = 81
    case GH = 82
    case GI = 83
    case GR = 84
    case GL = 85
    case GD = 86
    case GP = 87
    case GU = 88
    case GT = 89
    case GG = 90
    case GN = 91
    case GW = 92
    case GY = 93
    case HT = 94
    case HM = 95
    case HN = 96
    case HK = 97
    case HU = 98
    case IS = 99
    case IN = 100
    case ID = 101
    case IR = 102
    case IQ = 103
    case IE = 104
    case IM = 105
    case IL = 106
    case IT = 107
    case JM = 108
    case JP = 109
    case JE = 110
    case JO = 111
    case KZ = 112
    case KE = 113
    case KI = 114
    case KW = 115
    case KG = 116
    case LA = 117
    case LV = 118
    case LB = 119
    case LS = 120
    case LR = 121
    case LY = 122
    case LI = 123
    case LT = 124
    case LU = 125
    case MO = 126
    case MK = 127
    case MG = 128
    case MW = 129
    case MY = 130
    case MV = 131
    case ML = 132
    case MT = 133
    case MH = 134
    case MQ = 135
    case MR = 136
    case MU = 137
    case YT = 138
    case MX = 139
    case FM = 140
    case MD = 141
    case MC = 142
    case MN = 143
    case ME = 144
    case MS = 145
    case MA = 146
    case MZ = 147
    case MM = 148
    case NA = 149
    case NR = 150
    case NP = 151
    case NL = 152
    case AN = 153
    case NC = 154
    case NZ = 155
    case NI = 156
    case NE = 157
    case NG = 158
    case NU = 159
    case NF = 160
    case KP = 161
    case MP = 162
    case NO = 163
    case OM = 164
    case PK = 165
    case PW = 166
    case PS = 167
    case PA = 168
    case PG = 169
    case PY = 170
    case PE = 171
    case PH = 172
    case PN = 173
    case PL = 174
    case PT = 175
    case PR = 176
    case QA = 177
    case RE = 178
    case RO = 179
    case RU = 180
    case RW = 181
    case BL = 182
    case SH = 183
    case KN = 184
    case LC = 185
    case MF = 186
    case PM = 187
    case VC = 188
    case WS = 189
    case SM = 190
    case ST = 191
    case SA = 192
    case SN = 193
    case RS = 194
    case SC = 195
    case SL = 196
    case SG = 197
    case SX = 198
    case SK = 199
    case SI = 200
    case SB = 201
    case SO = 202
    case ZA = 203
    case GS = 204
    case KR = 205
    case SS = 206
    case ES = 207
    case LK = 208
    case SD = 209
    case SR = 210
    case SJ = 211
    case SZ = 212
    case SE = 213
    case CH = 214
    case SY = 215
    case TW = 216
    case TJ = 217
    case TZ = 218
    case TH = 219
    case CD = 220
    case TL = 221
    case TG = 222
    case TK = 223
    case TO = 224
    case TT = 225
    case TN = 226
    case TR = 227
    case TM = 228
    case TC = 229
    case TV = 230
    case VI = 231
    case UG = 232
    case UA = 233
    case AE = 234
    case GB = 235
    case US = 236
    case UM = 237
    case UY = 238
    case UZ = 239
    case VU = 240
    case VA = 241
    case VE = 242
    case VN = 243
    case WF = 244
    case EH = 245
    case YE = 246
    case ZM = 247
    case ZW = 248
    case AX = 249
    
    public var description: String {
        switch self {
            case .AF: return "Afghanistan"
            case .AL: return "Albania"
            case .DZ: return "Algeria"
            case .AS: return "American Samoa"
            case .AD: return "Andorra"
            case .AO: return "Angola"
            case .AI: return "Anguilla"
            case .AQ: return "Antarctica"
            case .AG: return "Antigua and Barbuda"
            case .AR: return "Argentina"
            case .AM: return "Armenia"
            case .AW: return "Aruba"
            case .AU: return "Australia"
            case .AT: return "Austria"
            case .AZ: return "Azerbaijan"
            case .BS: return "Bahamas"
            case .BH: return "Bahrain"
            case .BD: return "Bangladesh"
            case .BB: return "Barbados"
            case .BY: return "Belarus"
            case .BE: return "Belgium"
            case .BZ: return "Belize"
            case .BJ: return "Benin"
            case .BM: return "Bermuda"
            case .BT: return "Bhutan"
            case .BO: return "Bolivia"
            case .BQ: return "Bonaire, Sint Eustatius and Saba"
            case .BA: return "Bosnia and Herzegovina"
            case .BW: return "Botswana"
            case .BV: return "Bouvet Island"
            case .BR: return "Brazil"
            case .IO: return "British Indian Ocean Territory"
            case .VG: return "British Virgin Islands"
            case .BN: return "Brunei"
            case .BG: return "Bulgaria"
            case .BF: return "Burkina Faso"
            case .BI: return "Burundi"
            case .KH: return "Cambodia"
            case .CM: return "Cameroon"
            case .CA: return "Canada"
            case .CV: return "Cape Verde"
            case .KY: return "Cayman Islands"
            case .CF: return "Central African Republic"
            case .TD: return "Chad"
            case .CL: return "Chile"
            case .CN: return "China"
            case .CX: return "Christmas Island"
            case .CC: return "Cocos Islands"
            case .CO: return "Colombia"
            case .KM: return "Comoros"
            case .CG: return "Congo"
            case .CK: return "Cook Islands"
            case .CR: return "Costa Rica"
            case .HR: return "Croatia"
            case .CU: return "Cuba"
            case .CW: return "Curaçao"
            case .CY: return "Cyprus"
            case .CZ: return "Czech Republic"
            case .CI: return "Côte d'Ivoire"
            case .DK: return "Denmark"
            case .DJ: return "Djibouti"
            case .DM: return "Dominica"
            case .DO: return "Dominican Republic"
            case .EC: return "Ecuador"
            case .EG: return "Egypt"
            case .SV: return "El Salvador"
            case .GQ: return "Equatorial Guinea"
            case .ER: return "Eritrea"
            case .EE: return "Estonia"
            case .ET: return "Ethiopia"
            case .FK: return "Falkland Islands"
            case .FO: return "Faroe Islands"
            case .FJ: return "Fiji"
            case .FI: return "Finland"
            case .FR: return "France"
            case .GF: return "French Guiana"
            case .PF: return "French Polynesia"
            case .TF: return "French Southern Territories"
            case .GA: return "Gabon"
            case .GM: return "Gambia"
            case .GE: return "Georgia"
            case .DE: return "Germany"
            case .GH: return "Ghana"
            case .GI: return "Gibraltar"
            case .GR: return "Greece"
            case .GL: return "Greenland"
            case .GD: return "Grenada"
            case .GP: return "Guadeloupe"
            case .GU: return "Guam"
            case .GT: return "Guatemala"
            case .GG: return "Guernsey"
            case .GN: return "Guinea"
            case .GW: return "Guinea-Bissau"
            case .GY: return "Guyana"
            case .HT: return "Haiti"
            case .HM: return "Heard Island And McDonald Islands"
            case .HN: return "Honduras"
            case .HK: return "Hong Kong"
            case .HU: return "Hungary"
            case .IS: return "Iceland"
            case .IN: return "India"
            case .ID: return "Indonesia"
            case .IR: return "Iran"
            case .IQ: return "Iraq"
            case .IE: return "Ireland"
            case .IM: return "Isle Of Man"
            case .IL: return "Israel"
            case .IT: return "Italy"
            case .JM: return "Jamaica"
            case .JP: return "Japan"
            case .JE: return "Jersey"
            case .JO: return "Jordan"
            case .KZ: return "Kazakhstan"
            case .KE: return "Kenya"
            case .KI: return "Kiribati"
            case .KW: return "Kuwait"
            case .KG: return "Kyrgyzstan"
            case .LA: return "Laos"
            case .LV: return "Latvia"
            case .LB: return "Lebanon"
            case .LS: return "Lesotho"
            case .LR: return "Liberia"
            case .LY: return "Libya"
            case .LI: return "Liechtenstein"
            case .LT: return "Lithuania"
            case .LU: return "Luxembourg"
            case .MO: return "Macao"
            case .MK: return "Macedonia"
            case .MG: return "Madagascar"
            case .MW: return "Malawi"
            case .MY: return "Malaysia"
            case .MV: return "Maldives"
            case .ML: return "Mali"
            case .MT: return "Malta"
            case .MH: return "Marshall Islands"
            case .MQ: return "Martinique"
            case .MR: return "Mauritania"
            case .MU: return "Mauritius"
            case .YT: return "Mayotte"
            case .MX: return "Mexico"
            case .FM: return "Micronesia"
            case .MD: return "Moldova"
            case .MC: return "Monaco"
            case .MN: return "Mongolia"
            case .ME: return "Montenegro"
            case .MS: return "Montserrat"
            case .MA: return "Morocco"
            case .MZ: return "Mozambique"
            case .MM: return "Myanmar"
            case .NA: return "Namibia"
            case .NR: return "Nauru"
            case .NP: return "Nepal"
            case .NL: return "Netherlands"
            case .AN: return "Netherlands Antilles"
            case .NC: return "New Caledonia"
            case .NZ: return "New Zealand"
            case .NI: return "Nicaragua"
            case .NE: return "Niger"
            case .NG: return "Nigeria"
            case .NU: return "Niue"
            case .NF: return "Norfolk Island"
            case .KP: return "North Korea"
            case .MP: return "Northern Mariana Islands"
            case .NO: return "Norway"
            case .OM: return "Oman"
            case .PK: return "Pakistan"
            case .PW: return "Palau"
            case .PS: return "Palestine"
            case .PA: return "Panama"
            case .PG: return "Papua New Guinea"
            case .PY: return "Paraguay"
            case .PE: return "Peru"
            case .PH: return "Philippines"
            case .PN: return "Pitcairn"
            case .PL: return "Poland"
            case .PT: return "Portugal"
            case .PR: return "Puerto Rico"
            case .QA: return "Qatar"
            case .RE: return "Reunion"
            case .RO: return "Romania"
            case .RU: return "Russia"
            case .RW: return "Rwanda"
            case .BL: return "Saint Barthélemy"
            case .SH: return "Saint Helena"
            case .KN: return "Saint Kitts And Nevis"
            case .LC: return "Saint Lucia"
            case .MF: return "Saint Martin"
            case .PM: return "Saint Pierre And Miquelon"
            case .VC: return "Saint Vincent And The Grenadines"
            case .WS: return "Samoa"
            case .SM: return "San Marino"
            case .ST: return "Sao Tome And Principe"
            case .SA: return "Saudi Arabia"
            case .SN: return "Senegal"
            case .RS: return "Serbia"
            case .SC: return "Seychelles"
            case .SL: return "Sierra Leone"
            case .SG: return "Singapore"
            case .SX: return "Sint Maarten (Dutch part)"
            case .SK: return "Slovakia"
            case .SI: return "Slovenia"
            case .SB: return "Solomon Islands"
            case .SO: return "Somalia"
            case .ZA: return "South Africa"
            case .GS: return "South Georgia And The South Sandwich Islands"
            case .KR: return "South Korea"
            case .SS: return "South Sudan"
            case .ES: return "Spain"
            case .LK: return "Sri Lanka"
            case .SD: return "Sudan"
            case .SR: return "Suriname"
            case .SJ: return "Svalbard And Jan Mayen"
            case .SZ: return "Swaziland"
            case .SE: return "Sweden"
            case .CH: return "Switzerland"
            case .SY: return "Syria"
            case .TW: return "Taiwan"
            case .TJ: return "Tajikistan"
            case .TZ: return "Tanzania"
            case .TH: return "Thailand"
            case .CD: return "The Democratic Republic Of Congo"
            case .TL: return "Timor-Leste"
            case .TG: return "Togo"
            case .TK: return "Tokelau"
            case .TO: return "Tonga"
            case .TT: return "Trinidad and Tobago"
            case .TN: return "Tunisia"
            case .TR: return "Turkey"
            case .TM: return "Turkmenistan"
            case .TC: return "Turks And Caicos Islands"
            case .TV: return "Tuvalu"
            case .VI: return "U.S. Virgin Islands"
            case .UG: return "Uganda"
            case .UA: return "Ukraine"
            case .AE: return "United Arab Emirates"
            case .GB: return "United Kingdom"
            case .US: return "United States"
            case .UM: return "United States Minor Outlying Islands"
            case .UY: return "Uruguay"
            case .UZ: return "Uzbekistan"
            case .VU: return "Vanuatu"
            case .VA: return "Vatican"
            case .VE: return "Venezuela"
            case .VN: return "Vietnam"
            case .WF: return "Wallis And Futuna"
            case .EH: return "Western Sahara"
            case .YE: return "Yemen"
            case .ZM: return "Zambia"
            case .ZW: return "Zimbabwe"
            case .AX: return "Åland Islands"
        }
    }
    
    public static func fromString(constant: String) -> CountryName? {
        var i = 0
        while let enumItem = CountryName(rawValue: i) {
            if String(describing: enumItem) == constant {
                return enumItem
            }
            i = i + 1
        }
        
        return nil
    }
    
    public static func fromOptionalString(constant: String?) -> CountryName? {
        if constant == nil {
            return nil
        }
        
        var i = 0
        while let enumItem = CountryName(rawValue: i) {
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
        
        while let enumItem = CountryName(rawValue: i) {
            enumItems.append(String(describing: enumItem))
            i = i + 1
        }
        
        return enumItems
    }
    
    public static func allDescriptions() -> [String] {
        var enumDescriptions = [String]()
        var i = 0
        
        while let enumItem = AddressType(rawValue: i) {
            enumDescriptions.append(enumItem.description)
            i = i + 1
        }
        
        return enumDescriptions
    }    
}
