//
//  ItemLocalizedText.swift
//  NeoDB
//
//  Created by citron on 1/15/25.
//

import Foundation

public struct ItemLocalizedText: Codable, Equatable, Hashable, Sendable {
    public let lang: KnownLanguage
    public let text: String
}

extension ItemLocalizedText {
    public enum KnownLanguage: String, Codable, CaseIterable, Hashable, Equatable, Sendable {
        case zhCn = "zh-cn"
        case zhTw = "zh-tw"
        case zhHk = "zh-hk"
        case en = "en"
        case es = "es"
        case fr = "fr"
        case de = "de"
        case pt = "pt"
        case ja = "ja"
        case ko = "ko"
        case it = "it"
        case ru = "ru"
        case nl = "nl"
        case kr = "kr"
        case hi = "hi"
        case ar = "ar"
        case bn = "bn"
        case aa = "aa"
        case af = "af"
        case ak = "ak"
        case an = "an"
        case `as` = "as"
        case av = "av"
        case ae = "ae"
        case ay = "ay"
        case az = "az"
        case ba = "ba"
        case bm = "bm"
        case bi = "bi"
        case bo = "bo"
        case br = "br"
        case ca = "ca"
        case cs = "cs"
        case ce = "ce"
        case cu = "cu"
        case cv = "cv"
        case kw = "kw"
        case co = "co"
        case cr = "cr"
        case cy = "cy"
        case da = "da"
        case dv = "dv"
        case dz = "dz"
        case eo = "eo"
        case et = "et"
        case eu = "eu"
        case fo = "fo"
        case fj = "fj"
        case fi = "fi"
        case fy = "fy"
        case ff = "ff"
        case gd = "gd"
        case ga = "ga"
        case gl = "gl"
        case gv = "gv"
        case gn = "gn"
        case gu = "gu"
        case ht = "ht"
        case ha = "ha"
        case sh = "sh"
        case hz = "hz"
        case ho = "ho"
        case hr = "hr"
        case hu = "hu"
        case ig = "ig"
        case io = "io"
        case ii = "ii"
        case iu = "iu"
        case ie = "ie"
        case ia = "ia"
        case id = "id"
        case ik = "ik"
        case `is` = "is"
        case jv = "jv"
        case kl = "kl"
        case kn = "kn"
        case ks = "ks"
        case kk = "kk"
        case km = "km"
        case ki = "ki"
        case rw = "rw"
        case ky = "ky"
        case kv = "kv"
        case kg = "kg"
        case kj = "kj"
        case ku = "ku"
        case lo = "lo"
        case la = "la"
        case lv = "lv"
        case li = "li"
        case ln = "ln"
        case lt = "lt"
        case lb = "lb"
        case lu = "lu"
        case lg = "lg"
        case mh = "mh"
        case ml = "ml"
        case mr = "mr"
        case mg = "mg"
        case mt = "mt"
        case mo = "mo"
        case mn = "mn"
        case mi = "mi"
        case ms = "ms"
        case my = "my"
        case na = "na"
        case nv = "nv"
        case nr = "nr"
        case nd = "nd"
        case ng = "ng"
        case ne = "ne"
        case nn = "nn"
        case nb = "nb"
        case no = "no"
        case ny = "ny"
        case oc = "oc"
        case oj = "oj"
        case or = "or"
        case om = "om"
        case os = "os"
        case pi = "pi"
        case pl = "pl"
        case qu = "qu"
        case rm = "rm"
        case ro = "ro"
        case rn = "rn"
        case sg = "sg"
        case sa = "sa"
        case si = "si"
        case sk = "sk"
        case sl = "sl"
        case se = "se"
        case sm = "sm"
        case sn = "sn"
        case sd = "sd"
        case so = "so"
        case st = "st"
        case sq = "sq"
        case sc = "sc"
        case sr = "sr"
        case ss = "ss"
        case su = "su"
        case sw = "sw"
        case sv = "sv"
        case ty = "ty"
        case ta = "ta"
        case tt = "tt"
        case te = "te"
        case tg = "tg"
        case tl = "tl"
        case th = "th"
        case ti = "ti"
        case to = "to"
        case tn = "tn"
        case ts = "ts"
        case tk = "tk"
        case tr = "tr"
        case tw = "tw"
        case ug = "ug"
        case uk = "uk"
        case ur = "ur"
        case uz = "uz"
        case ve = "ve"
        case vi = "vi"
        case vo = "vo"
        case wa = "wa"
        case wo = "wo"
        case xh = "xh"
        case yi = "yi"
        case za = "za"
        case zu = "zu"
        case ab = "ab"
        case ps = "ps"
        case am = "am"
        case bg = "bg"
        case mk = "mk"
        case el = "el"
        case fa = "fa"
        case he = "he"
        case hy = "hy"
        case ee = "ee"
        case ka = "ka"
        case pa = "pa"
        case bs = "bs"
        case ch = "ch"
        case be = "be"
        case yo = "yo"
        case ptBr = "pt-br"
        case zhSg = "zh-sg"
        case zhMy = "zh-my"
        case zhMo = "zh-mo"
        case zhHans = "zh-hans"
        case zhHant = "zh-hant"
        case zh = "zh"
        case unknown = "x"

        public var displayName: String {
            switch self {
            case .zhCn: return String(localized: "neodb.item.localized_text.lang.zh_cn.label", defaultValue: "Simplified Chinese (China)", bundle: .module, comment: "Language name for zh-cn (Simplified Chinese / 简体中文)")
            case .zhTw: return String(localized: "neodb.item.localized_text.lang.zh_tw.label", defaultValue: "Traditional Chinese (Taiwan)", bundle: .module, comment: "Language name for zh-tw (Traditional Chinese / 繁體中文)")
            case .zhHk: return String(localized: "neodb.item.localized_text.lang.zh_hk.label", defaultValue: "Traditional Chinese (Hongkong)", bundle: .module, comment: "Language name for zh-hk (Traditional Chinese / 繁體中文)")
            case .en: return String(localized: "neodb.item.localized_text.lang.en.label", defaultValue: "English", bundle: .module, comment: "Language name for en (English / English)")
            case .es: return String(localized: "neodb.item.localized_text.lang.es.label", defaultValue: "Spanish", bundle: .module, comment: "Language name for es (Spanish / Español)")
            case .fr: return String(localized: "neodb.item.localized_text.lang.fr.label", defaultValue: "French", bundle: .module, comment: "Language name for fr (French / Français)")
            case .de: return String(localized: "neodb.item.localized_text.lang.de.label", defaultValue: "German", bundle: .module, comment: "Language name for de (German / Deutsch)")
            case .pt: return String(localized: "neodb.item.localized_text.lang.pt.label", defaultValue: "Portuguese", bundle: .module, comment: "Language name for pt (Portuguese / Português)")
            case .ja: return String(localized: "neodb.item.localized_text.lang.ja.label", defaultValue: "Japanese", bundle: .module, comment: "Language name for ja (Japanese / 日本語)")
            case .ko: return String(localized: "neodb.item.localized_text.lang.ko.label", defaultValue: "Korean", bundle: .module, comment: "Language name for ko (Korean / 한국어)")
            case .it: return String(localized: "neodb.item.localized_text.lang.it.label", defaultValue: "Italian", bundle: .module, comment: "Language name for it (Italian / Italiano)")
            case .ru: return String(localized: "neodb.item.localized_text.lang.ru.label", defaultValue: "Russian", bundle: .module, comment: "Language name for ru (Russian / Русский)")
            case .nl: return String(localized: "neodb.item.localized_text.lang.nl.label", defaultValue: "Dutch", bundle: .module, comment: "Language name for nl (Dutch / Nederlands)")
            case .kr: return String(localized: "neodb.item.localized_text.lang.kr.label", defaultValue: "Kanuri", bundle: .module, comment: "Language name for kr (Kanuri / Kanuri)")
            case .hi: return String(localized: "neodb.item.localized_text.lang.hi.label", defaultValue: "Hindi", bundle: .module, comment: "Language name for hi (Hindi / हिन्दी)")
            case .ar: return String(localized: "neodb.item.localized_text.lang.ar.label", defaultValue: "Arabic", bundle: .module, comment: "Language name for ar (Arabic / العربية)")
            case .bn: return String(localized: "neodb.item.localized_text.lang.bn.label", defaultValue: "Bengali", bundle: .module, comment: "Language name for bn (Bengali / বাংলা)")
            case .aa: return String(localized: "neodb.item.localized_text.lang.aa.label", defaultValue: "Afar", bundle: .module, comment: "Language name for aa (Afar / Afaraf)")
            case .af: return String(localized: "neodb.item.localized_text.lang.af.label", defaultValue: "Afrikaans", bundle: .module, comment: "Language name for af (Afrikaans / Afrikaans)")
            case .ak: return String(localized: "neodb.item.localized_text.lang.ak.label", defaultValue: "Akan", bundle: .module, comment: "Language name for ak (Akan / Akan)")
            case .an: return String(localized: "neodb.item.localized_text.lang.an.label", defaultValue: "Aragonese", bundle: .module, comment: "Language name for an (Aragonese / Aragonés)")
            case .as: return String(localized: "neodb.item.localized_text.lang.as.label", defaultValue: "Assamese", bundle: .module, comment: "Language name for as (Assamese / অসমীয়া)")
            case .av: return String(localized: "neodb.item.localized_text.lang.av.label", defaultValue: "Avaric", bundle: .module, comment: "Language name for av (Avaric / авар мацӀ)")
            case .ae: return String(localized: "neodb.item.localized_text.lang.ae.label", defaultValue: "Avestan", bundle: .module, comment: "Language name for ae (Avestan / avesta)")
            case .ay: return String(localized: "neodb.item.localized_text.lang.ay.label", defaultValue: "Aymara", bundle: .module, comment: "Language name for ay (Aymara / aymar aru)")
            case .az: return String(localized: "neodb.item.localized_text.lang.az.label", defaultValue: "Azerbaijani", bundle: .module, comment: "Language name for az (Azerbaijani / azərbaycan dili)")
            case .ba: return String(localized: "neodb.item.localized_text.lang.ba.label", defaultValue: "Bashkir", bundle: .module, comment: "Language name for ba (Bashkir / башҡорт теле)")
            case .bm: return String(localized: "neodb.item.localized_text.lang.bm.label", defaultValue: "Bambara", bundle: .module, comment: "Language name for bm (Bambara / bamanankan)")
            case .bi: return String(localized: "neodb.item.localized_text.lang.bi.label", defaultValue: "Bislama", bundle: .module, comment: "Language name for bi (Bislama / Bislama)")
            case .bo: return String(localized: "neodb.item.localized_text.lang.bo.label", defaultValue: "Tibetan", bundle: .module, comment: "Language name for bo (Tibetan / བོད་ཡིག)")
            case .br: return String(localized: "neodb.item.localized_text.lang.br.label", defaultValue: "Breton", bundle: .module, comment: "Language name for br (Breton / brezhoneg)")
            case .ca: return String(localized: "neodb.item.localized_text.lang.ca.label", defaultValue: "Catalan", bundle: .module, comment: "Language name for ca (Catalan / català)")
            case .cs: return String(localized: "neodb.item.localized_text.lang.cs.label", defaultValue: "Czech", bundle: .module, comment: "Language name for cs (Czech / čeština)")
            case .ce: return String(localized: "neodb.item.localized_text.lang.ce.label", defaultValue: "Chechen", bundle: .module, comment: "Language name for ce (Chechen / нохчийн мott)")
            case .cu: return String(localized: "neodb.item.localized_text.lang.cu.label", defaultValue: "Slavic", bundle: .module, comment: "Language name for cu (Church Slavic / ѩзыкъ словѣньскъ)")
            case .cv: return String(localized: "neodb.item.localized_text.lang.cv.label", defaultValue: "Chuvash", bundle: .module, comment: "Language name for cv (Chuvash / чӑваш чӗлхи)")
            case .kw: return String(localized: "neodb.item.localized_text.lang.kw.label", defaultValue: "Cornish", bundle: .module, comment: "Language name for kw (Cornish / Kernewek)")
            case .co: return String(localized: "neodb.item.localized_text.lang.co.label", defaultValue: "Corsican", bundle: .module, comment: "Language name for co (Corsican / corsu)")
            case .cr: return String(localized: "neodb.item.localized_text.lang.cr.label", defaultValue: "Cree", bundle: .module, comment: "Language name for cr (Cree / ᓀᐦᐃᔭᐍᐏᐣ)")
            case .cy: return String(localized: "neodb.item.localized_text.lang.cy.label", defaultValue: "Welsh", bundle: .module, comment: "Language name for cy (Welsh / Cymraeg)")
            case .da: return String(localized: "neodb.item.localized_text.lang.da.label", defaultValue: "Danish", bundle: .module, comment: "Language name for da (Danish / dansk)")
            case .dv: return String(localized: "neodb.item.localized_text.lang.dv.label", defaultValue: "Divehi", bundle: .module, comment: "Language name for dv (Divehi / ދިވެހި)")
            case .dz: return String(localized: "neodb.item.localized_text.lang.dz.label", defaultValue: "Dzongkha", bundle: .module, comment: "Language name for dz (Dzongkha / རྫོང་ཁ)")
            case .eo: return String(localized: "neodb.item.localized_text.lang.eo.label", defaultValue: "Esperanto", bundle: .module, comment: "Language name for eo (Esperanto / Esperanto)")
            case .et: return String(localized: "neodb.item.localized_text.lang.et.label", defaultValue: "Estonian", bundle: .module, comment: "Language name for et (Estonian / eesti)")
            case .eu: return String(localized: "neodb.item.localized_text.lang.eu.label", defaultValue: "Basque", bundle: .module, comment: "Language name for eu (Basque / euskara)")
            case .fo: return String(localized: "neodb.item.localized_text.lang.fo.label", defaultValue: "Faroese", bundle: .module, comment: "Language name for fo (Faroese / føroyskt)")
            case .fj: return String(localized: "neodb.item.localized_text.lang.fj.label", defaultValue: "Fijian", bundle: .module, comment: "Language name for fj (Fijian / vosa Vakaviti)")
            case .fi: return String(localized: "neodb.item.localized_text.lang.fi.label", defaultValue: "Finnish", bundle: .module, comment: "Language name for fi (Finnish / suomi)")
            case .fy: return String(localized: "neodb.item.localized_text.lang.fy.label", defaultValue: "Frisian", bundle: .module, comment: "Language name for fy (Western Frisian / Frysk)")
            case .ff: return String(localized: "neodb.item.localized_text.lang.ff.label", defaultValue: "Fulah", bundle: .module, comment: "Language name for ff (Fulah / Fulfulde)")
            case .gd: return String(localized: "neodb.item.localized_text.lang.gd.label", defaultValue: "Gaelic", bundle: .module, comment: "Language name for gd (Scottish Gaelic / Gàidhlig)")
            case .ga: return String(localized: "neodb.item.localized_text.lang.ga.label", defaultValue: "Irish", bundle: .module, comment: "Language name for ga (Irish / Gaeilge)")
            case .gl: return String(localized: "neodb.item.localized_text.lang.gl.label", defaultValue: "Galician", bundle: .module, comment: "Language name for gl (Galician / galego)")
            case .gv: return String(localized: "neodb.item.localized_text.lang.gv.label", defaultValue: "Manx", bundle: .module, comment: "Language name for gv (Manx / Gaelg)")
            case .gn: return String(localized: "neodb.item.localized_text.lang.gn.label", defaultValue: "Guarani", bundle: .module, comment: "Language name for gn (Guarani / Avañe'ẽ)")
            case .gu: return String(localized: "neodb.item.localized_text.lang.gu.label", defaultValue: "Gujarati", bundle: .module, comment: "Language name for gu (Gujarati / ગુજરાતી)")
            case .ht: return String(localized: "neodb.item.localized_text.lang.ht.label", defaultValue: "Haitian", bundle: .module, comment: "Language name for ht (Haitian Creole / Kreyòl ayisyen)")
            case .ha: return String(localized: "neodb.item.localized_text.lang.ha.label", defaultValue: "Hausa", bundle: .module, comment: "Language name for ha (Hausa / Hausa)")
            case .sh: return String(localized: "neodb.item.localized_text.lang.sh.label", defaultValue: "Serbo-Croatian", bundle: .module, comment: "Language name for sh (Serbo-Croatian / srpskohrvatski)")
            case .hz: return String(localized: "neodb.item.localized_text.lang.hz.label", defaultValue: "Herero", bundle: .module, comment: "Language name for hz (Herero / Otjiherero)")
            case .ho: return String(localized: "neodb.item.localized_text.lang.ho.label", defaultValue: "Hiri Motu", bundle: .module, comment: "Language name for ho (Hiri Motu / Hiri Motu)")
            case .hr: return String(localized: "neodb.item.localized_text.lang.hr.label", defaultValue: "Croatian", bundle: .module, comment: "Language name for hr (Croatian / hrvatski)")
            case .hu: return String(localized: "neodb.item.localized_text.lang.hu.label", defaultValue: "Hungarian", bundle: .module, comment: "Language name for hu (Hungarian / magyar)")
            case .ig: return String(localized: "neodb.item.localized_text.lang.ig.label", defaultValue: "Igbo", bundle: .module, comment: "Language name for ig (Igbo / Igbo)")
            case .io: return String(localized: "neodb.item.localized_text.lang.io.label", defaultValue: "Ido", bundle: .module, comment: "Language name for io (Ido / Ido)")
            case .ii: return String(localized: "neodb.item.localized_text.lang.ii.label", defaultValue: "Yi", bundle: .module, comment: "Language name for ii (Sichuan Yi / ꆈꌠ꒿)")
            case .iu: return String(localized: "neodb.item.localized_text.lang.iu.label", defaultValue: "Inuktitut", bundle: .module, comment: "Language name for iu (Inuktitut / ᐃᓄᒃᑎᑐᑦ)")
            case .ie: return String(localized: "neodb.item.localized_text.lang.ie.label", defaultValue: "Interlingue", bundle: .module, comment: "Language name for ie (Interlingue / Interlingue)")
            case .ia: return String(localized: "neodb.item.localized_text.lang.ia.label", defaultValue: "Interlingua", bundle: .module, comment: "Language name for ia (Interlingua / Interlingua)")
            case .id: return String(localized: "neodb.item.localized_text.lang.id.label", defaultValue: "Indonesian", bundle: .module, comment: "Language name for id (Indonesian / Bahasa Indonesia)")
            case .ik: return String(localized: "neodb.item.localized_text.lang.ik.label", defaultValue: "Inupiaq", bundle: .module, comment: "Language name for ik (Inupiaq / Iñupiaq)")
            case .is: return String(localized: "neodb.item.localized_text.lang.is.label", defaultValue: "Icelandic", bundle: .module, comment: "Language name for is (Icelandic / Íslenska)")
            case .jv: return String(localized: "neodb.item.localized_text.lang.jv.label", defaultValue: "Javanese", bundle: .module, comment: "Language name for jv (Javanese / basa Jawa)")
            case .kl: return String(localized: "neodb.item.localized_text.lang.kl.label", defaultValue: "Kalaallisut", bundle: .module, comment: "Language name for kl (Kalaallisut / kalaallisut)")
            case .kn: return String(localized: "neodb.item.localized_text.lang.kn.label", defaultValue: "Kannada", bundle: .module, comment: "Language name for kn (Kannada / ಕನ್ನಡ)")
            case .ks: return String(localized: "neodb.item.localized_text.lang.ks.label", defaultValue: "Kashmiri", bundle: .module, comment: "Language name for ks (Kashmiri / كٲشُر)")
            case .kk: return String(localized: "neodb.item.localized_text.lang.kk.label", defaultValue: "Kazakh", bundle: .module, comment: "Language name for kk (Kazakh / қазақ тілі)")
            case .km: return String(localized: "neodb.item.localized_text.lang.km.label", defaultValue: "Khmer", bundle: .module, comment: "Language name for km (Khmer / ខ្មែរ)")
            case .ki: return String(localized: "neodb.item.localized_text.lang.ki.label", defaultValue: "Kikuyu", bundle: .module, comment: "Language name for ki (Kikuyu / Gĩkũyũ)")
            case .rw: return String(localized: "neodb.item.localized_text.lang.rw.label", defaultValue: "Kinyarwanda", bundle: .module, comment: "Language name for rw (Kinyarwanda / Ikinyarwanda)")
            case .ky: return String(localized: "neodb.item.localized_text.lang.ky.label", defaultValue: "Kirghiz", bundle: .module, comment: "Language name for ky (Kirghiz / кыргыз тили)")
            case .kv: return String(localized: "neodb.item.localized_text.lang.kv.label", defaultValue: "Komi", bundle: .module, comment: "Language name for kv (Komi / коми кыв)")
            case .kg: return String(localized: "neodb.item.localized_text.lang.kg.label", defaultValue: "Kongo", bundle: .module, comment: "Language name for kg (Kongo / KiKongo)")
            case .kj: return String(localized: "neodb.item.localized_text.lang.kj.label", defaultValue: "Kuanyama", bundle: .module, comment: "Language name for kj (Kuanyama / Kuanyama)")
            case .ku: return String(localized: "neodb.item.localized_text.lang.ku.label", defaultValue: "Kurdish", bundle: .module, comment: "Language name for ku (Kurdish / Kurdî)")
            case .lo: return String(localized: "neodb.item.localized_text.lang.lo.label", defaultValue: "Lao", bundle: .module, comment: "Language name for lo (Lao / ພາສາລາວ)")
            case .la: return String(localized: "neodb.item.localized_text.lang.la.label", defaultValue: "Latin", bundle: .module, comment: "Language name for la (Latin / latine)")
            case .lv: return String(localized: "neodb.item.localized_text.lang.lv.label", defaultValue: "Latvian", bundle: .module, comment: "Language name for lv (Latvian / latviešu valoda)")
            case .li: return String(localized: "neodb.item.localized_text.lang.li.label", defaultValue: "Limburgish", bundle: .module, comment: "Language name for li (Limburgish / Limburgs)")
            case .ln: return String(localized: "neodb.item.localized_text.lang.ln.label", defaultValue: "Lingala", bundle: .module, comment: "Language name for ln (Lingala / Lingála)")
            case .lt: return String(localized: "neodb.item.localized_text.lang.lt.label", defaultValue: "Lithuanian", bundle: .module, comment: "Language name for lt (Lithuanian / lietuvių kalba)")
            case .lb: return String(localized: "neodb.item.localized_text.lang.lb.label", defaultValue: "Letzeburgesch", bundle: .module, comment: "Language name for lb (Luxembourgish / Lëtzebuergesch)")
            case .lu: return String(localized: "neodb.item.localized_text.lang.lu.label", defaultValue: "Luba-Katanga", bundle: .module, comment: "Language name for lu (Luba-Katanga / Tshiluba)")
            case .lg: return String(localized: "neodb.item.localized_text.lang.lg.label", defaultValue: "Ganda", bundle: .module, comment: "Language name for lg (Ganda / Luganda)")
            case .mh: return String(localized: "neodb.item.localized_text.lang.mh.label", defaultValue: "Marshall", bundle: .module, comment: "Language name for mh (Marshallese / Kajin M̧ajeļ)")
            case .ml: return String(localized: "neodb.item.localized_text.lang.ml.label", defaultValue: "Malayalam", bundle: .module, comment: "Language name for ml (Malayalam / മലയാളം)")
            case .mr: return String(localized: "neodb.item.localized_text.lang.mr.label", defaultValue: "Marathi", bundle: .module, comment: "Language name for mr (Marathi / मराठी)")
            case .mg: return String(localized: "neodb.item.localized_text.lang.mg.label", defaultValue: "Malagasy", bundle: .module, comment: "Language name for mg (Malagasy / Malagasy)")
            case .mt: return String(localized: "neodb.item.localized_text.lang.mt.label", defaultValue: "Maltese", bundle: .module, comment: "Language name for mt (Maltese / Malti)")
            case .mo: return String(localized: "neodb.item.localized_text.lang.mo.label", defaultValue: "Moldavian", bundle: .module, comment: "Language name for mo (Moldavian / limba moldovenească)")
            case .mn: return String(localized: "neodb.item.localized_text.lang.mn.label", defaultValue: "Mongolian", bundle: .module, comment: "Language name for mn (Mongolian / монгол)")
            case .mi: return String(localized: "neodb.item.localized_text.lang.mi.label", defaultValue: "Maori", bundle: .module, comment: "Language name for mi (Maori / te reo Māori)")
            case .ms: return String(localized: "neodb.item.localized_text.lang.ms.label", defaultValue: "Malay", bundle: .module, comment: "Language name for ms (Malay / bahasa Melayu)")
            case .my: return String(localized: "neodb.item.localized_text.lang.my.label", defaultValue: "Burmese", bundle: .module, comment: "Language name for my (Burmese / ဗမာစာ)")
            case .na: return String(localized: "neodb.item.localized_text.lang.na.label", defaultValue: "Nauru", bundle: .module, comment: "Language name for na (Nauru / Ekakairũ Naoero)")
            case .nv: return String(localized: "neodb.item.localized_text.lang.nv.label", defaultValue: "Navajo", bundle: .module, comment: "Language name for nv (Navajo / Diné bizaad)")
            case .nr: return String(localized: "neodb.item.localized_text.lang.nr.label", defaultValue: "Ndebele", bundle: .module, comment: "Language name for nr (South Ndebele / isiNdebele)")
            case .nd: return String(localized: "neodb.item.localized_text.lang.nd.label", defaultValue: "Ndebele", bundle: .module, comment: "Language name for nd (North Ndebele / isiNdebele)")
            case .ng: return String(localized: "neodb.item.localized_text.lang.ng.label", defaultValue: "Ndonga", bundle: .module, comment: "Language name for ng (Ndonga / Owambo)")
            case .ne: return String(localized: "neodb.item.localized_text.lang.ne.label", defaultValue: "Nepali", bundle: .module, comment: "Language name for ne (Nepali / नेपाली)")
            case .nn: return String(localized: "neodb.item.localized_text.lang.nn.label", defaultValue: "Norwegian Nynorsk", bundle: .module, comment: "Language name for nn (Norwegian Nynorsk / norsk nynorsk)")
            case .nb: return String(localized: "neodb.item.localized_text.lang.nb.label", defaultValue: "Norwegian Bokmål", bundle: .module, comment: "Language name for nb (Norwegian Bokmål / norsk bokmål)")
            case .no: return String(localized: "neodb.item.localized_text.lang.no.label", defaultValue: "Norwegian", bundle: .module, comment: "Language name for no (Norwegian / norsk)")
            case .ny: return String(localized: "neodb.item.localized_text.lang.ny.label", defaultValue: "Chichewa", bundle: .module, comment: "Language name for ny (Chichewa / chiCheŵa)")
            case .oc: return String(localized: "neodb.item.localized_text.lang.oc.label", defaultValue: "Occitan", bundle: .module, comment: "Language name for oc (Occitan / occitan)")
            case .oj: return String(localized: "neodb.item.localized_text.lang.oj.label", defaultValue: "Ojibwa", bundle: .module, comment: "Language name for oj (Ojibwa / ᐊᓂᔑᓈᐯᒧᐎᓐ)")
            case .or: return String(localized: "neodb.item.localized_text.lang.or.label", defaultValue: "Oriya", bundle: .module, comment: "Language name for or (Oriya / ଓଡ଼ିଆ)")
            case .om: return String(localized: "neodb.item.localized_text.lang.om.label", defaultValue: "Oromo", bundle: .module, comment: "Language name for om (Oromo / Afaan Oromoo)")
            case .os: return String(localized: "neodb.item.localized_text.lang.os.label", defaultValue: "Ossetian", bundle: .module, comment: "Language name for os (Ossetian / ирон æвзаг)")
            case .pi: return String(localized: "neodb.item.localized_text.lang.pi.label", defaultValue: "Pali", bundle: .module, comment: "Language name for pi (Pali / पाऴि)")
            case .pl: return String(localized: "neodb.item.localized_text.lang.pl.label", defaultValue: "Polish", bundle: .module, comment: "Language name for pl (Polish / polski)")
            case .qu: return String(localized: "neodb.item.localized_text.lang.qu.label", defaultValue: "Quechua", bundle: .module, comment: "Language name for qu (Quechua / Runa Simi)")
            case .rm: return String(localized: "neodb.item.localized_text.lang.rm.label", defaultValue: "Raeto-Romance", bundle: .module, comment: "Language name for rm (Romansh / rumantsch grischun)")
            case .ro: return String(localized: "neodb.item.localized_text.lang.ro.label", defaultValue: "Romanian", bundle: .module, comment: "Language name for ro (Romanian / română)")
            case .rn: return String(localized: "neodb.item.localized_text.lang.rn.label", defaultValue: "Rundi", bundle: .module, comment: "Language name for rn (Rundi / kiRundi)")
            case .sg: return String(localized: "neodb.item.localized_text.lang.sg.label", defaultValue: "Sango", bundle: .module, comment: "Language name for sg (Sango / yângâ tî sängö)")
            case .sa: return String(localized: "neodb.item.localized_text.lang.sa.label", defaultValue: "Sanskrit", bundle: .module, comment: "Language name for sa (Sanskrit / संस्कृतम्)")
            case .si: return String(localized: "neodb.item.localized_text.lang.si.label", defaultValue: "Sinhalese", bundle: .module, comment: "Language name for si (Sinhalese / සිංහල)")
            case .sk: return String(localized: "neodb.item.localized_text.lang.sk.label", defaultValue: "Slovak", bundle: .module, comment: "Language name for sk (Slovak / slovenčina)")
            case .sl: return String(localized: "neodb.item.localized_text.lang.sl.label", defaultValue: "Slovenian", bundle: .module, comment: "Language name for sl (Slovenian / slovenščina)")
            case .se: return String(localized: "neodb.item.localized_text.lang.se.label", defaultValue: "Northern Sami", bundle: .module, comment: "Language name for se (Northern Sami / davvisámegiella)")
            case .sm: return String(localized: "neodb.item.localized_text.lang.sm.label", defaultValue: "Samoan", bundle: .module, comment: "Language name for sm (Samoan / gagana fa'a Samoa)")
            case .sn: return String(localized: "neodb.item.localized_text.lang.sn.label", defaultValue: "Shona", bundle: .module, comment: "Language name for sn (Shona / chiShona)")
            case .sd: return String(localized: "neodb.item.localized_text.lang.sd.label", defaultValue: "Sindhi", bundle: .module, comment: "Language name for sd (Sindhi / سنڌي)")
            case .so: return String(localized: "neodb.item.localized_text.lang.so.label", defaultValue: "Somali", bundle: .module, comment: "Language name for so (Somali / Soomaaliga)")
            case .st: return String(localized: "neodb.item.localized_text.lang.st.label", defaultValue: "Sotho", bundle: .module, comment: "Language name for st (Southern Sotho / Sesotho)")
            case .sq: return String(localized: "neodb.item.localized_text.lang.sq.label", defaultValue: "Albanian", bundle: .module, comment: "Language name for sq (Albanian / shqip)")
            case .sc: return String(localized: "neodb.item.localized_text.lang.sc.label", defaultValue: "Sardinian", bundle: .module, comment: "Language name for sc (Sardinian / sardu)")
            case .sr: return String(localized: "neodb.item.localized_text.lang.sr.label", defaultValue: "Serbian", bundle: .module, comment: "Language name for sr (Serbian / српски)")
            case .ss: return String(localized: "neodb.item.localized_text.lang.ss.label", defaultValue: "Swati", bundle: .module, comment: "Language name for ss (Swati / SiSwati)")
            case .su: return String(localized: "neodb.item.localized_text.lang.su.label", defaultValue: "Sundanese", bundle: .module, comment: "Language name for su (Sundanese / Basa Sunda)")
            case .sw: return String(localized: "neodb.item.localized_text.lang.sw.label", defaultValue: "Swahili", bundle: .module, comment: "Language name for sw (Swahili / Kiswahili)")
            case .sv: return String(localized: "neodb.item.localized_text.lang.sv.label", defaultValue: "Swedish", bundle: .module, comment: "Language name for sv (Swedish / svenska)")
            case .ty: return String(localized: "neodb.item.localized_text.lang.ty.label", defaultValue: "Tahitian", bundle: .module, comment: "Language name for ty (Tahitian / Reo Tahiti)")
            case .ta: return String(localized: "neodb.item.localized_text.lang.ta.label", defaultValue: "Tamil", bundle: .module, comment: "Language name for ta (Tamil / தமிழ்)")
            case .tt: return String(localized: "neodb.item.localized_text.lang.tt.label", defaultValue: "Tatar", bundle: .module, comment: "Language name for tt (Tatar / татарча)")
            case .te: return String(localized: "neodb.item.localized_text.lang.te.label", defaultValue: "Telugu", bundle: .module, comment: "Language name for te (Telugu / తెలుగు)")
            case .tg: return String(localized: "neodb.item.localized_text.lang.tg.label", defaultValue: "Tajik", bundle: .module, comment: "Language name for tg (Tajik / тоҷикӣ)")
            case .tl: return String(localized: "neodb.item.localized_text.lang.tl.label", defaultValue: "Tagalog", bundle: .module, comment: "Language name for tl (Tagalog / Wikang Tagalog)")
            case .th: return String(localized: "neodb.item.localized_text.lang.th.label", defaultValue: "Thai", bundle: .module, comment: "Language name for th (Thai / ไทย)")
            case .ti: return String(localized: "neodb.item.localized_text.lang.ti.label", defaultValue: "Tigrinya", bundle: .module, comment: "Language name for ti (Tigrinya / ትግርኛ)")
            case .to: return String(localized: "neodb.item.localized_text.lang.to.label", defaultValue: "Tonga", bundle: .module, comment: "Language name for to (Tonga / faka Tonga)")
            case .tn: return String(localized: "neodb.item.localized_text.lang.tn.label", defaultValue: "Tswana", bundle: .module, comment: "Language name for tn (Tswana / Setswana)")
            case .ts: return String(localized: "neodb.item.localized_text.lang.ts.label", defaultValue: "Tsonga", bundle: .module, comment: "Language name for ts (Tsonga / Xitsonga)")
            case .tk: return String(localized: "neodb.item.localized_text.lang.tk.label", defaultValue: "Turkmen", bundle: .module, comment: "Language name for tk (Turkmen / Türkmen)")
            case .tr: return String(localized: "neodb.item.localized_text.lang.tr.label", defaultValue: "Turkish", bundle: .module, comment: "Language name for tr (Turkish / Türkçe)")
            case .tw: return String(localized: "neodb.item.localized_text.lang.tw.label", defaultValue: "Twi", bundle: .module, comment: "Language name for tw (Twi / Twi)")
            case .ug: return String(localized: "neodb.item.localized_text.lang.ug.label", defaultValue: "Uighur", bundle: .module, comment: "Language name for ug (Uighur / ئۇيغۇرچە)")
            case .uk: return String(localized: "neodb.item.localized_text.lang.uk.label", defaultValue: "Ukrainian", bundle: .module, comment: "Language name for uk (Ukrainian / українська)")
            case .ur: return String(localized: "neodb.item.localized_text.lang.ur.label", defaultValue: "Urdu", bundle: .module, comment: "Language name for ur (Urdu / اردو)")
            case .uz: return String(localized: "neodb.item.localized_text.lang.uz.label", defaultValue: "Uzbek", bundle: .module, comment: "Language name for uz (Uzbek / oʻzbekcha)")
            case .ve: return String(localized: "neodb.item.localized_text.lang.ve.label", defaultValue: "Venda", bundle: .module, comment: "Language name for ve (Venda / Tshivenḓa)")
            case .vi: return String(localized: "neodb.item.localized_text.lang.vi.label", defaultValue: "Vietnamese", bundle: .module, comment: "Language name for vi (Vietnamese / Tiếng Việt)")
            case .vo: return String(localized: "neodb.item.localized_text.lang.vo.label", defaultValue: "Volapük", bundle: .module, comment: "Language name for vo (Volapük / Volapük)")
            case .wa: return String(localized: "neodb.item.localized_text.lang.wa.label", defaultValue: "Walloon", bundle: .module, comment: "Language name for wa (Walloon / walon)")
            case .wo: return String(localized: "neodb.item.localized_text.lang.wo.label", defaultValue: "Wolof", bundle: .module, comment: "Language name for wo (Wolof / Wollof)")
            case .xh: return String(localized: "neodb.item.localized_text.lang.xh.label", defaultValue: "Xhosa", bundle: .module, comment: "Language name for xh (Xhosa / isiXhosa)")
            case .yi: return String(localized: "neodb.item.localized_text.lang.yi.label", defaultValue: "Yiddish", bundle: .module, comment: "Language name for yi (Yiddish / ייִדיש)")
            case .za: return String(localized: "neodb.item.localized_text.lang.za.label", defaultValue: "Zhuang", bundle: .module, comment: "Language name for za (Zhuang / Saɯ cueŋƅ)")
            case .zu: return String(localized: "neodb.item.localized_text.lang.zu.label", defaultValue: "Zulu", bundle: .module, comment: "Language name for zu (Zulu / isiZulu)")
            case .ab: return String(localized: "neodb.item.localized_text.lang.ab.label", defaultValue: "Abkhazian", bundle: .module, comment: "Language name for ab (Abkhazian / аҧсуа)")
            case .ps: return String(localized: "neodb.item.localized_text.lang.ps.label", defaultValue: "Pushto", bundle: .module, comment: "Language name for ps (Pushto / پښتو)")
            case .am: return String(localized: "neodb.item.localized_text.lang.am.label", defaultValue: "Amharic", bundle: .module, comment: "Language name for am (Amharic / አማርኛ)")
            case .bg: return String(localized: "neodb.item.localized_text.lang.bg.label", defaultValue: "Bulgarian", bundle: .module, comment: "Language name for bg (Bulgarian / български)")
            case .mk: return String(localized: "neodb.item.localized_text.lang.mk.label", defaultValue: "Macedonian", bundle: .module, comment: "Language name for mk (Macedonian / македонски)")
            case .el: return String(localized: "neodb.item.localized_text.lang.el.label", defaultValue: "Greek", bundle: .module, comment: "Language name for el (Greek / Ελληνικά)")
            case .fa: return String(localized: "neodb.item.localized_text.lang.fa.label", defaultValue: "Persian", bundle: .module, comment: "Language name for fa (Persian / فارسی)")
            case .he: return String(localized: "neodb.item.localized_text.lang.he.label", defaultValue: "Hebrew", bundle: .module, comment: "Language name for he (Hebrew / עברית)")
            case .hy: return String(localized: "neodb.item.localized_text.lang.hy.label", defaultValue: "Armenian", bundle: .module, comment: "Language name for hy (Armenian / Հայերեն)")
            case .ee: return String(localized: "neodb.item.localized_text.lang.ee.label", defaultValue: "Ewe", bundle: .module, comment: "Language name for ee (Ewe / Eʋegbe)")
            case .ka: return String(localized: "neodb.item.localized_text.lang.ka.label", defaultValue: "Georgian", bundle: .module, comment: "Language name for ka (Georgian / ქართული)")
            case .pa: return String(localized: "neodb.item.localized_text.lang.pa.label", defaultValue: "Punjabi", bundle: .module, comment: "Language name for pa (Punjabi / ਪੰਜਾਬੀ)")
            case .bs: return String(localized: "neodb.item.localized_text.lang.bs.label", defaultValue: "Bosnian", bundle: .module, comment: "Language name for bs (Bosnian / bosanski)")
            case .ch: return String(localized: "neodb.item.localized_text.lang.ch.label", defaultValue: "Chamorro", bundle: .module, comment: "Language name for ch (Chamorro / Chamoru)")
            case .be: return String(localized: "neodb.item.localized_text.lang.be.label", defaultValue: "Belarusian", bundle: .module, comment: "Language name for be (Belarusian / беларуская)")
            case .yo: return String(localized: "neodb.item.localized_text.lang.yo.label", defaultValue: "Yoruba", bundle: .module, comment: "Language name for yo (Yoruba / Yorùbá)")
            case .ptBr: return String(localized: "neodb.item.localized_text.lang.pt_br.label", defaultValue: "Portuguese (Brazil)", bundle: .module, comment: "Language name for pt-br (Portuguese / Português)")
            case .zhSg: return String(localized: "neodb.item.localized_text.lang.zh_sg.label", defaultValue: "Simplified Chinese (Singapore)", bundle: .module, comment: "Language name for zh-sg (Simplified Chinese / 简体中文)")
            case .zhMy: return String(localized: "neodb.item.localized_text.lang.zh_my.label", defaultValue: "Simplified Chinese (Malaysia)", bundle: .module, comment: "Language name for zh-my (Simplified Chinese / 简体中文)")
            case .zhMo: return String(localized: "neodb.item.localized_text.lang.zh_mo.label", defaultValue: "Traditional Chinese (Macau)", bundle: .module, comment: "Language name for zh-mo (Traditional Chinese / 繁體中文)")
            case .zhHans: return String(localized: "neodb.item.localized_text.lang.zh_hans.label", defaultValue: "Simplified Chinese", bundle: .module, comment: "Language name for zh-hans (Simplified Chinese / 简体中文)")
            case .zhHant: return String(localized: "neodb.item.localized_text.lang.zh_hant.label", defaultValue: "Traditional Chinese", bundle: .module, comment: "Language name for zh-hant (Traditional Chinese / 繁體中文)")
            case .zh: return String(localized: "neodb.item.localized_text.lang.zh.label", defaultValue: "Chinese", bundle: .module, comment: "Language name for zh (Chinese / 中文)")
            case .unknown: return String(localized: "neodb.item.localized_text.lang.unknown.label", defaultValue: "Unknown", bundle: .module, comment: "Language name for x (Unknown / Unknown)")
            }
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawString = try container.decode(String.self)
            let normalizedString = rawString.lowercased().trimmingCharacters(in: .whitespaces)
            self = KnownLanguage(rawValue: normalizedString) ?? .unknown
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(self.rawValue)
        }

        public var displayNameWithoutUnknown: String? {
            switch self {
            case .unknown: return nil
            default: return displayName
            }
        }

        public var displayNameAbbreviated: String {
            switch self {
            case .zhCn: return String(localized: "neodb.item.localized_text.lang.zh_cn.label.abbreviated", defaultValue: "Simplified Chinese (CN)", bundle: .module, comment: "Abbreviated language name for zh-cn")
            case .zhTw: return String(localized: "neodb.item.localized_text.lang.zh_tw.label.abbreviated", defaultValue: "Traditional Chinese (TW)", bundle: .module, comment: "Abbreviated language name for zh-tw")
            case .zhHk: return String(localized: "neodb.item.localized_text.lang.zh_hk.label.abbreviated", defaultValue: "Traditional Chinese (HK)", bundle: .module, comment: "Abbreviated language name for zh-hk")
            case .ptBr: return String(localized: "neodb.item.localized_text.lang.pt_br.label.abbreviated", defaultValue: "Portuguese (BR)", bundle: .module, comment: "Abbreviated language name for pt-br")
            case .zhSg: return String(localized: "neodb.item.localized_text.lang.zh_sg.label.abbreviated", defaultValue: "Simplified Chinese (SG)", bundle: .module, comment: "Abbreviated language name for zh-sg")
            case .zhMy: return String(localized: "neodb.item.localized_text.lang.zh_my.label.abbreviated", defaultValue: "Simplified Chinese (MY)", bundle: .module, comment: "Abbreviated language name for zh-my")
            case .zhMo: return String(localized: "neodb.item.localized_text.lang.zh_mo.label.abbreviated", defaultValue: "Traditional Chinese (MO)", bundle: .module, comment: "Abbreviated language name for zh-mo")
            default: return displayName
            }
        }

        public var displayNameAbbreviatedWithoutUnknown: String? {
            switch self {
            case .unknown: return nil
            default: return displayNameAbbreviated
            }
        }

        public var displayNameCode: String {
            // If the user's system language is Chinese (any variant), prefer the abbreviated localized name.
            // if Self.isSystemLanguageChinese {
            //     return displayNameAbbreviated
            // }
            // Otherwise, keep Chinese variants abbreviated for consistency.
            // if isChinese { return displayNameAbbreviated }

            switch self {
            case .zhCn: return "ZH (CN)"
            case .zhTw: return "ZH (TW)"
            case .zhHk: return "ZH (HK)"
            case .en: return "EN"
            case .es: return "ES"
            case .fr: return "FR"
            case .de: return "DE"
            case .pt: return "PT"
            case .ja: return "JA"
            case .ko: return "KO"
            case .it: return "IT"
            case .ru: return "RU"
            case .nl: return "NL"
            case .kr: return "KR"
            case .hi: return "HI"
            case .ar: return "AR"
            case .bn: return "BN"
            case .aa: return "AA"
            case .af: return "AF"
            case .ak: return "AK"
            case .an: return "AN"
            case .as: return "AS"
            case .av: return "AV"
            case .ae: return "AE"
            case .ay: return "AY"
            case .az: return "AZ"
            case .ba: return "BA"
            case .bm: return "BM"
            case .bi: return "BI"
            case .bo: return "BO"
            case .br: return "BR"
            case .ca: return "CA"
            case .cs: return "CS"
            case .ce: return "CE"
            case .cu: return "CU"
            case .cv: return "CV"
            case .kw: return "KW"
            case .co: return "CO"
            case .cr: return "CR"
            case .cy: return "CY"
            case .da: return "DA"
            case .dv: return "DV"
            case .dz: return "DZ"
            case .eo: return "EO"
            case .et: return "ET"
            case .eu: return "EU"
            case .fo: return "FO"
            case .fj: return "FJ"
            case .fi: return "FI"
            case .fy: return "FY"
            case .ff: return "FF"
            case .gd: return "GD"
            case .ga: return "GA"
            case .gl: return "GL"
            case .gv: return "GV"
            case .gn: return "GN"
            case .gu: return "GU"
            case .ht: return "HT"
            case .ha: return "HA"
            case .sh: return "SH"
            case .hz: return "HZ"
            case .ho: return "HO"
            case .hr: return "HR"
            case .hu: return "HU"
            case .ig: return "IG"
            case .io: return "IO"
            case .ii: return "II"
            case .iu: return "IU"
            case .ie: return "IE"
            case .ia: return "IA"
            case .id: return "ID"
            case .ik: return "IK"
            case .is: return "IS"
            case .jv: return "JV"
            case .kl: return "KL"
            case .kn: return "KN"
            case .ks: return "KS"
            case .kk: return "KK"
            case .km: return "KM"
            case .ki: return "KI"
            case .rw: return "RW"
            case .ky: return "KY"
            case .kv: return "KV"
            case .kg: return "KG"
            case .kj: return "KJ"
            case .ku: return "KU"
            case .lo: return "LO"
            case .la: return "LA"
            case .lv: return "LV"
            case .li: return "LI"
            case .ln: return "LN"
            case .lt: return "LT"
            case .lb: return "LB"
            case .lu: return "LU"
            case .lg: return "LG"
            case .mh: return "MH"
            case .ml: return "ML"
            case .mr: return "MR"
            case .mg: return "MG"
            case .mt: return "MT"
            case .mo: return "MO"
            case .mn: return "MN"
            case .mi: return "MI"
            case .ms: return "MS"
            case .my: return "MY"
            case .na: return "NA"
            case .nv: return "NV"
            case .nr: return "NR"
            case .nd: return "ND"
            case .ng: return "NG"
            case .ne: return "NE"
            case .nn: return "NN"
            case .nb: return "NB"
            case .no: return "NO"
            case .ny: return "NY"
            case .oc: return "OC"
            case .oj: return "OJ"
            case .or: return "OR"
            case .om: return "OM"
            case .os: return "OS"
            case .pi: return "PI"
            case .pl: return "PL"
            case .qu: return "QU"
            case .rm: return "RM"
            case .ro: return "RO"
            case .rn: return "RN"
            case .sg: return "SG"
            case .sa: return "SA"
            case .si: return "SI"
            case .sk: return "SK"
            case .sl: return "SL"
            case .se: return "SE"
            case .sm: return "SM"
            case .sn: return "SN"
            case .sd: return "SD"
            case .so: return "SO"
            case .st: return "ST"
            case .sq: return "SQ"
            case .sc: return "SC"
            case .sr: return "SR"
            case .ss: return "SS"
            case .su: return "SU"
            case .sw: return "SW"
            case .sv: return "SV"
            case .ty: return "TY"
            case .ta: return "TA"
            case .tt: return "TT"
            case .te: return "TE"
            case .tg: return "TG"
            case .tl: return "TL"
            case .th: return "TH"
            case .ti: return "TI"
            case .to: return "TO"
            case .tn: return "TN"
            case .ts: return "TS"
            case .tk: return "TK"
            case .tr: return "TR"
            case .tw: return "TW"
            case .ug: return "UG"
            case .uk: return "UK"
            case .ur: return "UR"
            case .uz: return "UZ"
            case .ve: return "VE"
            case .vi: return "VI"
            case .vo: return "VO"
            case .wa: return "WA"
            case .wo: return "WO"
            case .xh: return "XH"
            case .yi: return "YI"
            case .za: return "ZA"
            case .zu: return "ZU"
            case .ab: return "AB"
            case .ps: return "PS"
            case .am: return "AM"
            case .bg: return "BG"
            case .mk: return "MK"
            case .el: return "EL"
            case .fa: return "FA"
            case .he: return "HE"
            case .hy: return "HY"
            case .ee: return "EE"
            case .ka: return "KA"
            case .pa: return "PA"
            case .bs: return "BS"
            case .ch: return "CH"
            case .be: return "BE"
            case .yo: return "YO"
            case .ptBr: return "PT (BR)"
            case .zhSg: return "ZH (SG)"
            case .zhMy: return "ZH (MY)"
            case .zhMo: return "ZH (MO)"
            case .zhHans: return "ZH-HANS"
            case .zhHant: return "ZH-HANT"
            case .zh: return "ZH"
            case .unknown: return "??"
            }
        }

        /// Whether the language is any Chinese variant (Simplified/Traditional and regional codes).
        public var isChinese: Bool {
            switch self {
            case .zhCn, .zhTw, .zhHk, .zhSg, .zhMy, .zhMo, .zhHans, .zhHant, .zh:
                return true
            default:
                return false
            }
        }

        private static var isSystemLanguageChinese: Bool {
            guard let preferred = Locale.preferredLanguages.first else { return false }
            let locale = Locale(identifier: preferred)
            let langCode = locale.language.languageCode?.identifier.lowercased() ?? ""
            if langCode.hasPrefix("zh") { return true }
            // As a secondary check, consider the full locale identifier for legacy strings like "zh_Hans_CN".
            return locale.identifier.lowercased().hasPrefix("zh")
        }

        public var displayNameCodeWithoutUnknown: String? {
           switch self {
            case .unknown: return nil
            default: return displayNameCode
            }
        }

        /// Returns the abbreviated name when the system language is Chinese; otherwise returns the code.
        public var displayNameCodeAndNameAbbreviatedInChinese: String {
            if Self.isSystemLanguageChinese {
                return displayNameAbbreviated
            }
            return displayNameCode
        }

        public var displayNameCodeAndNameAbbreviatedInChineseWithoutUnknown: String? {
            switch self {
            case .unknown: return nil
            default: return displayNameCodeAndNameAbbreviatedInChinese
            }
        }

        /// Maps an iOS locale (e.g., system language) to a KnownLanguage when possible.
        /// Falls back to `.unknown` if no reasonable match is found.
        public static func from(locale: Locale) -> KnownLanguage {
            let langCode = locale.language.languageCode?.identifier ?? ""
            let scriptCode = locale.language.script?.identifier ?? ""
            let regionCode = locale.language.region?.identifier
                ?? locale.region?.identifier
                ?? ""

            let normalizedLang = langCode.lowercased()
            let normalizedScript = scriptCode.lowercased()
            let normalizedRegion = regionCode.lowercased()

            let candidates = [
                [normalizedLang, normalizedScript].filter { !$0.isEmpty }.joined(separator: "-"),
                [normalizedLang, normalizedRegion].filter { !$0.isEmpty }.joined(separator: "-"),
                normalizedLang
            ].filter { !$0.isEmpty }

            for candidate in candidates {
                if let match = KnownLanguage(rawValue: candidate) {
                    return match
                }
            }
            return .unknown
        }

        /// Convenience helper to map directly from a locale identifier string (e.g., "zh-Hans-CN").
        public static func from(localeIdentifier: String) -> KnownLanguage {
            from(locale: Locale(identifier: localeIdentifier))
        }
    }
}

// MARK: - Locale helpers for collections
extension Collection where Element == ItemLocalizedText {
    /// Returns the text that best matches the user's preferred languages.
    /// Falls back to English, then the first available entry.
    public var textForCurrentLocale: String? {
        let texts = Array(self)

        for localeId in Locale.preferredLanguages {
            let locale = Locale(identifier: localeId)
            let known = ItemLocalizedText.KnownLanguage.from(locale: locale)

            if let hit = texts.first(where: { $0.lang == known }) {
                return hit.text
            }

            if let code = locale.language.languageCode?.identifier.lowercased(),
               let hit = texts.first(where: { $0.lang.rawValue.hasPrefix(code) }) {
                return hit.text
            }
        }

        if let english = texts.first(where: { $0.lang == .en }) {
            return english.text
        }

        return texts.first?.text
    }

    public func textForLanguage(_ language: ItemLocalizedText.KnownLanguage) -> String? {
        return first(where: { $0.lang == language })?.text
    }
}
