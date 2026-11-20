# Dua sources

The dua database is `assets/data/duas.json`: 68 duas, all
`"verified": true` on Mariam's sign-off after the source checks below — the
base 50 on 2026-11-14, the 18 adhkar for waking and before sleep (the
Library's alert-free shelves) on 2026-11-18. A dua added later starts with
`"verified": false`, so the app shows "[verify attribution before release]"
under it until its source is checked.

## Waking and sleep adhkar — 2026-11-18

From Hisn al-Muslim's chapters "upon waking" (1–4) and "before sleeping"
(99–111), each traced to its primary source on sunnah.com:

- **Arabic cut from the source**, never typed: the hadith page's own text
  (matched letter by letter, vowel marks and all), or the Quran API
  ("quran-simple") for Al 'Imran 190–200 and al-Baqarah 285–286. Ayat
  al-Kursi, the Mu'awwidhat, the tasbih and `fatir-as-samawat` reuse the
  already verified text of the same words elsewhere in the list.
- **Each one is its own entry with the source for that moment** (Ayat
  al-Kursi before sleep cites al-Bukhari 2311, not the morning adhkar's
  reference), tagged `occasions` instead of `windows`, so none shows for an
  alert window. Search lists a repeated text once.
- **Checked by script** like the 2026-11-14 check: every hadith text is on
  its page; the expected partial matches are the Quran passages (the
  hadith only names them), the tasbih (named with verbs) and
  `waking-taarra` (joined round the narrator's "then he said").
- **Grading:** Bukhari and Muslim, or the grade sunnah.com shows, or
  at-Tirmidhi's own; for Abu Dawud 5045 al-Albani's grading from
  [dorar.net](https://dorar.net/h/OXYcrLYR) (see Notes). At-Tirmidhi 3401,
  which he graded hasan, is also in al-Albani's Sahih al-Jami' (716).
- **Second-source check before sign-off:** every text compared with Hisn
  al-Muslim's (sunnah.com/hisn): identical, or differing only where we
  follow the original's wording (listed under Notes) or in spelling
  (السماوات/السموات, مُئوي/مُؤوي); the four Quran passages match quran.com's
  text letter for letter. Verified on Mariam's sign-off, 2026-11-18.

## Source check — 2026-11-14

Every dua was re-checked against the page it links to, by script:

- **Arabic text:** found word for word (ignoring harakat and the spelling of
  hamza and alif forms) on its sunnah.com page, or equal to the Quran text
  (api.alquran.cloud, "quran-simple") for Quranic duas and for surahs
  112–114 in the two Mu'awwidhat entries. The expected differences are the
  ones under Notes (the Hisn's morning wording, the narrator's aside cut,
  al-Awza'i's أستغفر الله, ﷺ written out), plus the 33× tasbih, tahmid and
  takbir, which Muslim 597 names with verbs (سبّح، حمد، كبّر).
- **Grading:** Bukhari and Muslim; otherwise the grade sunnah.com shows
  (al-Albani or Darussalam: sahih, hasan, or a hasan chain), or, for the
  duas only in Hisn al-Muslim, its reference to al-Albani's grading.
- **Dropped:** `salawat-10` (see Left out). Al-Albani graded it hasan in
  Sahih at-Targhib — the Hisn's reference — but later retracted and graded
  it da'if in as-Silsila ad-Da'ifa 5788
  ([IslamQA 130213](https://islamqa.info/ar/answers/130213),
  [Ibn Baz](https://binbaz.org.sa/fatwas/15762)). The salawat itself is in
  the list in its authenticated form (`salawat-ibrahimiyya`).
- **Not covered:** our transliterations and English meanings.

## How the list was made

- **Arabic text is never retyped.** It was cut programmatically from the source:
  the primary hadith page on sunnah.com where the dua can be cut out cleanly,
  otherwise the official Hisn al-Muslim text (hisnmuslim.com), and the Quran
  text (api.alquran.cloud, Tanzil "simple") for Quranic duas. Only typography
  was cleaned (tatweel, a dotless ya used for ya, spacing). Each cut was
  checked letter-for-letter against its source page.
- **Only well-authenticated narrations:** Bukhari/Muslim, or graded sahih/hasan
  by al-Albani as shown on sunnah.com or cited in Hisn al-Muslim.
- **Transliterations and English meanings are ours** (not copied from a
  published translation) and need a read-through.
- **Repeat counts** come from the hadith; duas without one have 1.
- **Arabic meanings:** none written (only the design's dua has one), so Arabic
  mode shows the dua and its source only.

## Not on sunnah.com — checked against Hisn al-Muslim's reference only

`ayat-al-kursi` (an-Nasa'i al-Kubra, al-Hakim), `ibn-masud` (Ahmad),
`ya-hayyu-ya-qayyum` (al-Hakim), `fitrat-al-islam` (Ahmad; the evening wording
swaps أصبحنا → أمسينا as the Hisn instructs), `tahlil-10` (an-Nasa'i, 'Amal
al-Yawm wal-Layla; al-Albani: hasan in Sahih at-Targhib, chain sahih in
as-Silsila as-Sahiha 114).

## Left out

| Hisn al-Muslim | Dua | Why |
|---|---|---|
| 80 | اللهم إني أصبحت أشهدك… (×4) | Abu Dawud 5069 — graded da'if by al-Albani |
| 81 | اللهم ما أصبح بي من نعمة… | Abu Dawud 5073 — da'if (al-Albani) |
| 83 | حسبي الله لا إله إلا هو… (×7) | Abu Dawud 5081 — graded mawdu' (fabricated) by al-Albani |
| 87 | رضيت بالله ربا… (×3) | Abu Dawud 5072 — da'if (al-Albani) |
| 89 | أصبحنا وأصبح الملك لله رب العالمين، اللهم إني أسألك خير هذا اليوم… | Abu Dawud 5084 — da'if (al-Albani) |
| 82 | اللهم عافني في بدني… | Primary source not found to confirm its grading |
| 110 | Reciting as-Sajda and al-Mulk before sleep | Whole surahs, read from a mushaf — not a dua to show here |
| 112–118 | Turning over in bed, fear, bad dreams, qunut | Other chapters than "before sleeping" |
| 98 | من صلى عليّ حين يصبح عشرا… (salawat ×10, morning and evening) | at-Tabarani — al-Albani retracted his hasan grading: da'if in as-Silsila ad-Da'ifa 5788. Dropped 2026-11-14 |
| 72 | لا إله إلا الله… يحيي ويميت (×10) | Only after Fajr and Maghrib; the Dua screen doesn't know which prayer yet |
| — | "When it rains" | No rain window in v1 |

## Notes

- `afw`: the dua is Ibn Majah 3850's wording (no "كريم"). The printed Tirmidhi
  3513 has "عفوٌّ كريم" — the Arabic meaning line from the design follows that.
- `after-salam`: the words أستغفر الله come from al-Awza'i's explanation in
  Muslim 591, taken from the Hisn (66); the rest is Muslim 591.
- `al-afiyah`: Abu Dawud 5074 has عورتي (and عوراتي in 'Uthman's narration);
  the narrator's aside was cut out.
- `ya-hayyu-ya-qayyum`: the Hisn text lacks one kasra (أَسْتَغيثُ); left as given.

- `waking-taarra`: al-Bukhari 1154's wording, for waking in the night,
  with its "then he said: O Allah, forgive me" joined on. The Hisn (2)
  quotes Ibn Majah 3878 (رب اغفر لي, and العلي العظيم).
- `waking-al-imran`: al-Bukhari 183 has the Prophet ﷺ recite "the closing
  ten verses" of Al 'Imran on waking; 4569 starts at verse 190; the Hisn
  (4) gives 3:190–200.
- `sleep-ayat-al-kursi`: al-Bukhari 2311 is a mu'allaq report (he cites it
  without his own chain: وقال عثمان بن الهيثم…), connected by others; the
  Hisn (100) cites it.
- `sleep-bismika-rabbi`: al-Bukhari 6320's wording (رَبِّ, إِنْ without
  فـ). Muslim 2714 has other words (سبحانك اللهم ربي بك وضعت جنبي); the Hisn
  (102) follows at-Tirmidhi 3401.
- `sleep-khalaqta-nafsi`: Muslim 2712's wording, without the Hisn's إنك.
- `sleep-qini-adhabak`: al-Albani graded Abu Dawud 5045 sahih **without
  the words "three times"**, so it repeats once although the Hisn (104)
  says three.
- Bedtime tasbih: al-Bukhari 3705 and Muslim 2727 give the takbir 34 (as
  the Hisn, 106); al-Bukhari 6318 has 33 each, with Ibn Sirin's "the
  tasbih is 34".
- `sleep-rabb-as-samawat`: Muslim 2713's wording (رب السماوات ورب الأرض;
  the Hisn, 107, has السبع).
- `sleep-aslamtu`: al-Bukhari 6311's wording (أسلمت وجهي; Muslim 2710 and
  the Hisn, 111: أسلمت نفسي … ووجهت وجهي). Last on the shelf: "make them
  the last thing you say".

## Last third of the night

| # | id | Opening | Repeat | Reference |
|---|---|---|---|---|
| 1 | `afw` | اللَّهُمَّ إِنَّكَ عَفُوٌّ تُحِبُّ الْعَفْوَ فَاعْفُ … | 1 | [Narrated by Aisha (ra) — Ibn Majah 3850, at-Tirmidhi 3513](https://sunnah.com/ibnmajah:3850) |
| 2 | `sayyid-al-istighfar` | اللَّهُمَّ أَنْتَ رَبِّي، لاَ إِلَهَ إِلاَّ … | 1 | [Sahih al-Bukhari 6306 — the master of seeking forgiveness](https://sunnah.com/bukhari:6306) |
| 3 | `zalamtu-nafsi` | اللَّهُمَّ إِنِّي ظَلَمْتُ نَفْسِي ظُلْمًا كَثِيرًا … | 1 | [Sahih al-Bukhari 834, Sahih Muslim 2705](https://sunnah.com/bukhari:834) |
| 4 | `ighfir-li-ma-qaddamtu` | اللَّهُمَّ اغْفِرْ لِي مَا قَدَّمْتُ وَمَا … | 1 | [Sahih Muslim 771](https://sunnah.com/muslim:771) |
| 5 | `rabbighfir-li-wa-tub` | رَبِّ اغْفِرْ لِي وَتُبْ عَلَيَّ إِنَّكَ … | 1 | [Abu Dawud 1516 (graded sahih by al-Albani)](https://sunnah.com/abudawud:1516) |
| 6 | `dua-yunus` | لَا إِلَٰهَ إِلَّا أَنْتَ سُبْحَانَكَ إِنِّي … | 1 | [Quran 21:87 — at-Tirmidhi 3505](https://quran.com/21/87) |
| 7 | `rabbana-atina` | رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي … | 1 | [Quran 2:201 — the Prophet's ﷺ most frequent dua: al-Bukhari 6389](https://quran.com/2/201) |
| 8 | `al-jannah` | اللَّهُمَّ إِنِّي أَسْأَلُكَ الْجَنَّةَ وَأَعُوذُ بِكَ … | 1 | [Abu Dawud 792 (graded sahih by al-Albani)](https://sunnah.com/abudawud:792) |
| 9 | `huda-tuqa` | اللَّهُمَّ إِنِّي أَسْأَلُكَ الْهُدَى وَالتُّقَى وَالْعَفَافَ … | 1 | [Sahih Muslim 2721](https://sunnah.com/muslim:2721) |
| 10 | `aslih-li-dini` | اللَّهُمَّ أَصْلِحْ لِي دِينِيَ الَّذِي هُوَ … | 1 | [Sahih Muslim 2720](https://sunnah.com/muslim:2720) |
| 11 | `ya-muqallib` | يَا مُقَلِّبَ الْقُلُوبِ ثَبِّتْ قَلْبِي عَلَى … | 1 | [at-Tirmidhi 3522 — among the Prophet's ﷺ most frequent duas](https://sunnah.com/tirmidhi:3522) |
| 12 | `la-tuzigh-qulubana` | رَبَّنَا لَا تُزِغْ قُلُوبَنَا بَعْدَ إِذْ … | 1 | [Quran 3:8](https://quran.com/3/8) |
| 13 | `zalamna-anfusana` | رَبَّنَا ظَلَمْنَا أَنْفُسَنَا وَإِنْ لَمْ تَغْفِرْ … | 1 | [Quran 7:23](https://quran.com/7/23) |
| 14 | `walidayya` | رَبَّنَا اغْفِرْ لِي وَلِوَالِدَيَّ وَلِلْمُؤْمِنِينَ يَوْمَ … | 1 | [Quran 14:41](https://quran.com/14/41) |
| 15 | `hab-lana` | رَبَّنَا هَبْ لَنَا مِنْ أَزْوَاجِنَا وَذُرِّيَّاتِنَا … | 1 | [Quran 25:74](https://quran.com/25/74) |
| 16 | `hamm-wal-hazan` | اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ … | 1 | [Sahih al-Bukhari 6369](https://sunnah.com/bukhari:6369) |
| 17 | `ibn-masud` | اللَّهُمَّ إِنِّي عَبْدُكَ، ابْنُ عَبْدِكَ، ابْنُ … | 1 | [Ahmad (graded sahih by al-Albani) — Hisn al-Muslim 120](https://sunnah.com/hisn:120) |
| 18 | `rahmataka-arju` | اللَّهُمَّ رَحْمَتَكَ أَرْجُو فَلاَ تَكِلْنِي إِلَى … | 1 | [Abu Dawud 5090 (chain graded hasan by al-Albani)](https://sunnah.com/abudawud:5090) |
| 19 | `astaghfirullah-wa-atubu` | أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ | 100 | [Sahih al-Bukhari 6307, Sahih Muslim 2702 — a hundred times a day](https://sunnah.com/bukhari:6307) |

## Between adhan and iqama

| # | id | Opening | Repeat | Reference |
|---|---|---|---|---|
| 1 | `adhan-shahada` | أَشْهَدُ أَنْ لاَ إِلَهَ إِلاَّ اللَّهُ … | 1 | [Sahih Muslim 386 — said after the muezzin's testimony](https://sunnah.com/muslim:386) |
| 2 | `after-adhan` | اللَّهُمَّ رَبَّ هَذِهِ الدَّعْوَةِ التَّامَّةِ وَالصَّلاَةِ … | 1 | [Sahih al-Bukhari 614 — said after the adhan](https://sunnah.com/bukhari:614) |
| 3 | `afw` | اللَّهُمَّ إِنَّكَ عَفُوٌّ تُحِبُّ الْعَفْوَ فَاعْفُ … | 1 | [Narrated by Aisha (ra) — Ibn Majah 3850, at-Tirmidhi 3513](https://sunnah.com/ibnmajah:3850) |
| 4 | `zalamtu-nafsi` | اللَّهُمَّ إِنِّي ظَلَمْتُ نَفْسِي ظُلْمًا كَثِيرًا … | 1 | [Sahih al-Bukhari 834, Sahih Muslim 2705](https://sunnah.com/bukhari:834) |
| 5 | `rabbana-atina` | رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي … | 1 | [Quran 2:201 — the Prophet's ﷺ most frequent dua: al-Bukhari 6389](https://quran.com/2/201) |
| 6 | `al-jannah` | اللَّهُمَّ إِنِّي أَسْأَلُكَ الْجَنَّةَ وَأَعُوذُ بِكَ … | 1 | [Abu Dawud 792 (graded sahih by al-Albani)](https://sunnah.com/abudawud:792) |
| 7 | `huda-tuqa` | اللَّهُمَّ إِنِّي أَسْأَلُكَ الْهُدَى وَالتُّقَى وَالْعَفَافَ … | 1 | [Sahih Muslim 2721](https://sunnah.com/muslim:2721) |
| 8 | `ishrah-sadri` | رَبِّ اشْرَحْ لِي صَدْرِي وَيَسِّرْ لِي … | 1 | [Quran 20:25–26](https://quran.com/20/25-26) |
| 9 | `zidni-ilma` | رَبِّ زِدْنِي عِلْمًا | 1 | [Quran 20:114](https://quran.com/20/114) |

## After the obligatory prayer

| # | id | Opening | Repeat | Reference |
|---|---|---|---|---|
| 1 | `after-salam` | أَسْتَغْفِرُ اللَّهَ، أَسْتَغْفِرُ اللَّهَ، أَسْتَغْفِرُ اللَّهَ. … | 1 | [Sahih Muslim 591](https://sunnah.com/muslim:591) |
| 2 | `la-mani` | لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ … | 1 | [Sahih al-Bukhari 844, Sahih Muslim 593](https://sunnah.com/bukhari:844) |
| 3 | `lahun-nima` | لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ … | 1 | [Sahih Muslim 594](https://sunnah.com/muslim:594) |
| 4 | `subhanallah-33` | سُبْحَانَ اللَّهِ | 33 | [Sahih Muslim 597 — 33 times after each prayer](https://sunnah.com/muslim:597) |
| 5 | `alhamdulillah-33` | الْحَمْدُ لِلَّهِ | 33 | [Sahih Muslim 597 — 33 times after each prayer](https://sunnah.com/muslim:597) |
| 6 | `allahuakbar-33` | اللَّهُ أَكْبَرُ | 33 | [Sahih Muslim 597 — 33 times after each prayer](https://sunnah.com/muslim:597) |
| 7 | `tamam-al-mia` | لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ … | 1 | [Sahih Muslim 597 — completing the hundred](https://sunnah.com/muslim:597) |
| 8 | `ayat-al-kursi` | اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ … | 1 | [Quran 2:255 — after each prayer (an-Nasa'i, al-Kubra) and morning and evening (al-Hakim), both graded sahih by al-Albani — Hisn al-Muslim 71, 75](https://quran.com/2/255) |
| 9 | `muawwidhat-after-prayer` | بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ قُلْ هُوَ … | 1 | [Surahs 112–114 — after each prayer: Abu Dawud 1523 (graded sahih by al-Albani)](https://sunnah.com/abudawud:1523) |
| 10 | `ainni` | اللَّهُمَّ أَعِنِّي عَلَى ذِكْرِكَ وَشُكْرِكَ وَحُسْنِ … | 1 | [Abu Dawud 1522 — after every prayer (graded sahih by al-Albani)](https://sunnah.com/abudawud:1522) |

## The hour of response (Friday)

| # | id | Opening | Repeat | Reference |
|---|---|---|---|---|
| 1 | `salawat-ibrahimiyya` | اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ، وَعَلَى آلِ … | 1 | [Sahih al-Bukhari 3370 — sending many blessings on the Prophet ﷺ on Friday: Abu Dawud 1047 (graded sahih by al-Albani)](https://sunnah.com/bukhari:3370) |
| 2 | `afw` | اللَّهُمَّ إِنَّكَ عَفُوٌّ تُحِبُّ الْعَفْوَ فَاعْفُ … | 1 | [Narrated by Aisha (ra) — Ibn Majah 3850, at-Tirmidhi 3513](https://sunnah.com/ibnmajah:3850) |
| 3 | `zalamtu-nafsi` | اللَّهُمَّ إِنِّي ظَلَمْتُ نَفْسِي ظُلْمًا كَثِيرًا … | 1 | [Sahih al-Bukhari 834, Sahih Muslim 2705](https://sunnah.com/bukhari:834) |
| 4 | `dua-yunus` | لَا إِلَٰهَ إِلَّا أَنْتَ سُبْحَانَكَ إِنِّي … | 1 | [Quran 21:87 — at-Tirmidhi 3505](https://quran.com/21/87) |
| 5 | `rabbana-atina` | رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي … | 1 | [Quran 2:201 — the Prophet's ﷺ most frequent dua: al-Bukhari 6389](https://quran.com/2/201) |
| 6 | `al-jannah` | اللَّهُمَّ إِنِّي أَسْأَلُكَ الْجَنَّةَ وَأَعُوذُ بِكَ … | 1 | [Abu Dawud 792 (graded sahih by al-Albani)](https://sunnah.com/abudawud:792) |
| 7 | `huda-tuqa` | اللَّهُمَّ إِنِّي أَسْأَلُكَ الْهُدَى وَالتُّقَى وَالْعَفَافَ … | 1 | [Sahih Muslim 2721](https://sunnah.com/muslim:2721) |
| 8 | `ya-muqallib` | يَا مُقَلِّبَ الْقُلُوبِ ثَبِّتْ قَلْبِي عَلَى … | 1 | [at-Tirmidhi 3522 — among the Prophet's ﷺ most frequent duas](https://sunnah.com/tirmidhi:3522) |
| 9 | `walidayya` | رَبَّنَا اغْفِرْ لِي وَلِوَالِدَيَّ وَلِلْمُؤْمِنِينَ يَوْمَ … | 1 | [Quran 14:41](https://quran.com/14/41) |
| 10 | `hab-lana` | رَبَّنَا هَبْ لَنَا مِنْ أَزْوَاجِنَا وَذُرِّيَّاتِنَا … | 1 | [Quran 25:74](https://quran.com/25/74) |
| 11 | `hamm-wal-hazan` | اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ … | 1 | [Sahih al-Bukhari 6369](https://sunnah.com/bukhari:6369) |

## Morning adhkar

| # | id | Opening | Repeat | Reference |
|---|---|---|---|---|
| 1 | `ayat-al-kursi` | اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ … | 1 | [Quran 2:255 — after each prayer (an-Nasa'i, al-Kubra) and morning and evening (al-Hakim), both graded sahih by al-Albani — Hisn al-Muslim 71, 75](https://quran.com/2/255) |
| 2 | `muawwidhat` | بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ قُلْ هُوَ … | 3 | [Surahs 112–114 — three times morning and evening: Abu Dawud 5082 (graded hasan by al-Albani)](https://sunnah.com/abudawud:5082) |
| 3 | `sayyid-al-istighfar` | اللَّهُمَّ أَنْتَ رَبِّي، لاَ إِلَهَ إِلاَّ … | 1 | [Sahih al-Bukhari 6306 — the master of seeking forgiveness](https://sunnah.com/bukhari:6306) |
| 4 | `asbahna-wal-mulk` | أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، … | 1 | [Sahih Muslim 2723 — morning wording as in Hisn al-Muslim 77](https://sunnah.com/muslim:2723b) |
| 5 | `bika-asbahna` | اللَّهُمَّ بِكَ أَصْبَحْنَا وَبِكَ أَمْسَيْنَا وَبِكَ … | 1 | [Abu Dawud 5068 (graded sahih by al-Albani)](https://sunnah.com/abudawud:5068) |
| 6 | `al-afiyah` | اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَافِيَةَ فِي الدُّنْيَا … | 1 | [Abu Dawud 5074 (graded sahih by al-Albani)](https://sunnah.com/abudawud:5074) |
| 7 | `fatir-as-samawat` | اللَّهُمَّ فَاطِرَ السَّمَوَاتِ وَالأَرْضِ عَالِمَ الْغَيْبِ … | 1 | [Abu Dawud 5067 (graded sahih by al-Albani)](https://sunnah.com/abudawud:5067) |
| 8 | `bismillah-alladhi` | بِسْمِ اللَّهِ الَّذِي لاَ يَضُرُّ مَعَ … | 3 | [Abu Dawud 5088 (graded sahih by al-Albani)](https://sunnah.com/abudawud:5088) |
| 9 | `ya-hayyu-ya-qayyum` | يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغيثُ … | 1 | [al-Hakim (graded sahih by al-Albani) — Hisn al-Muslim 88](https://sunnah.com/hisn:88) |
| 10 | `fitrat-al-islam` | أَصْبَحْنا عَلَى فِطْرَةِ الْإِسْلاَمِ، وَعَلَى كَلِمَةِ … | 1 | [Ahmad (graded sahih by al-Albani) — Hisn al-Muslim 90](https://sunnah.com/hisn:90) |
| 11 | `subhanallah-wa-bihamdih` | سُبْحَانَ اللَّهِ وَبِحَمْدِهِ | 100 | [Sahih Muslim 2692 — a hundred times morning and evening](https://sunnah.com/muslim:2692) |
| 12 | `tahlil-10` | لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ … | 10 | [an-Nasa'i, 'Amal al-Yawm wal-Layla (graded sahih by al-Albani) — Hisn al-Muslim 92](https://sunnah.com/hisn:92) |
| 13 | `adada-khalqih` | سُبْحَانَ اللَّهِ وَبِحَمْدِهِ عَدَدَ خَلْقِهِ وَرِضَا … | 3 | [Sahih Muslim 2726](https://sunnah.com/muslim:2726) |
| 14 | `ilman-nafian` | اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْمًا نَافِعًا، وَرِزْقًا … | 1 | [Ibn Majah 925 — after the Fajr prayer](https://sunnah.com/ibnmajah:925) |
| 15 | `astaghfirullah-wa-atubu` | أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ | 100 | [Sahih al-Bukhari 6307, Sahih Muslim 2702 — a hundred times a day](https://sunnah.com/bukhari:6307) |

## Evening adhkar

| # | id | Opening | Repeat | Reference |
|---|---|---|---|---|
| 1 | `ayat-al-kursi` | اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ … | 1 | [Quran 2:255 — after each prayer (an-Nasa'i, al-Kubra) and morning and evening (al-Hakim), both graded sahih by al-Albani — Hisn al-Muslim 71, 75](https://quran.com/2/255) |
| 2 | `muawwidhat` | بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ قُلْ هُوَ … | 3 | [Surahs 112–114 — three times morning and evening: Abu Dawud 5082 (graded hasan by al-Albani)](https://sunnah.com/abudawud:5082) |
| 3 | `sayyid-al-istighfar` | اللَّهُمَّ أَنْتَ رَبِّي، لاَ إِلَهَ إِلاَّ … | 1 | [Sahih al-Bukhari 6306 — the master of seeking forgiveness](https://sunnah.com/bukhari:6306) |
| 4 | `amsayna-wal-mulk` | أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ وَالْحَمْدُ لِلَّهِ … | 1 | [Sahih Muslim 2723](https://sunnah.com/muslim:2723b) |
| 5 | `bika-amsayna` | اللَّهُمَّ بِكَ أَمْسَيْنَا وَبِكَ نَحْيَا وَبِكَ … | 1 | [Abu Dawud 5068 (graded sahih by al-Albani)](https://sunnah.com/abudawud:5068) |
| 6 | `al-afiyah` | اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَافِيَةَ فِي الدُّنْيَا … | 1 | [Abu Dawud 5074 (graded sahih by al-Albani)](https://sunnah.com/abudawud:5074) |
| 7 | `fatir-as-samawat` | اللَّهُمَّ فَاطِرَ السَّمَوَاتِ وَالأَرْضِ عَالِمَ الْغَيْبِ … | 1 | [Abu Dawud 5067 (graded sahih by al-Albani)](https://sunnah.com/abudawud:5067) |
| 8 | `bismillah-alladhi` | بِسْمِ اللَّهِ الَّذِي لاَ يَضُرُّ مَعَ … | 3 | [Abu Dawud 5088 (graded sahih by al-Albani)](https://sunnah.com/abudawud:5088) |
| 9 | `ya-hayyu-ya-qayyum` | يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغيثُ … | 1 | [al-Hakim (graded sahih by al-Albani) — Hisn al-Muslim 88](https://sunnah.com/hisn:88) |
| 10 | `fitrat-al-islam-evening` | أَمْسَيْنَا عَلَى فِطْرَةِ الْإِسْلاَمِ، وَعَلَى كَلِمَةِ … | 1 | [Ahmad (graded sahih by al-Albani) — Hisn al-Muslim 90, evening wording](https://sunnah.com/hisn:90) |
| 11 | `subhanallah-wa-bihamdih` | سُبْحَانَ اللَّهِ وَبِحَمْدِهِ | 100 | [Sahih Muslim 2692 — a hundred times morning and evening](https://sunnah.com/muslim:2692) |
| 12 | `tahlil-10` | لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ … | 10 | [an-Nasa'i, 'Amal al-Yawm wal-Layla (graded sahih by al-Albani) — Hisn al-Muslim 92](https://sunnah.com/hisn:92) |
| 13 | `kalimatillah` | أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ … | 3 | [Sahih Muslim 2709 — three times in the evening, as in Hisn al-Muslim 97](https://sunnah.com/muslim:2709a) |

## Upon waking (no alert)

| # | id | Opening | Repeat | Reference |
|---|---|---|---|---|
| 1 | `waking-ahyana` | الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ … | 1 | [Sahih al-Bukhari 6312, Sahih Muslim 2711 — on waking up](https://sunnah.com/bukhari:6312) |
| 2 | `waking-afani` | الْحَمْدُ لِلَّهِ الَّذِي عَافَانِي فِي … | 1 | [at-Tirmidhi 3401, who graded it hasan — on waking up](https://sunnah.com/tirmidhi:3401) |
| 3 | `waking-taarra` | لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ … | 1 | [Sahih al-Bukhari 1154 — on waking in the night; then a dua is answered](https://sunnah.com/bukhari:1154) |
| 4 | `waking-al-imran` | إِنَّ فِي خَلْقِ السَّمَاوَاتِ وَالْأَرْضِ … | 1 | [Quran 3:190–200 — the Prophet ﷺ recited the closing verses of Al 'Imran on waking at night: al-Bukhari 183, 4569](https://quran.com/3/190-200) |

## Before sleeping (no alert)

| # | id | Opening | Repeat | Reference |
|---|---|---|---|---|
| 1 | `sleep-muawwidhat` | بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ | 3 | [Surahs 112–114 — blown into cupped hands, then wiped over the body, three times: Sahih al-Bukhari 5017](https://sunnah.com/bukhari:5017) |
| 2 | `sleep-ayat-al-kursi` | اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ … | 1 | [Quran 2:255 — whoever recites it in bed has a guardian from Allah all night: Sahih al-Bukhari 2311](https://sunnah.com/bukhari:2311) |
| 3 | `sleep-baqarah-end` | آمَنَ الرَّسُولُ بِمَا أُنْزِلَ إِلَيْهِ … | 1 | [Quran 2:285–286 — whoever recites them at night, they suffice him: Sahih al-Bukhari 5009, Sahih Muslim 807](https://sunnah.com/bukhari:5009) |
| 4 | `sleep-bismika-rabbi` | بِاسْمِكَ رَبِّ وَضَعْتُ جَنْبِي، وَبِكَ … | 1 | [Sahih al-Bukhari 6320 — on lying down](https://sunnah.com/bukhari:6320) |
| 5 | `sleep-khalaqta-nafsi` | اللَّهُمَّ خَلَقْتَ نَفْسِي وَأَنْتَ تَوَفَّاهَا … | 1 | [Sahih Muslim 2712 — on going to bed](https://sunnah.com/muslim:2712) |
| 6 | `sleep-qini-adhabak` | اللَّهُمَّ قِنِي عَذَابَكَ يَوْمَ تَبْعَثُ … | 1 | [Abu Dawud 5045 (graded sahih by al-Albani, without the words "three times")](https://sunnah.com/abudawud:5045) |
| 7 | `sleep-bismika-amutu` | بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا | 1 | [Sahih al-Bukhari 6324 — on going to sleep](https://sunnah.com/bukhari:6324) |
| 8 | `sleep-subhanallah-33` | سُبْحَانَ اللَّهِ | 33 | [Sahih al-Bukhari 3705, Sahih Muslim 2727 — 33 times at bedtime](https://sunnah.com/bukhari:3705) |
| 9 | `sleep-alhamdulillah-33` | الْحَمْدُ لِلَّهِ | 33 | [Sahih al-Bukhari 3705, Sahih Muslim 2727 — 33 times at bedtime](https://sunnah.com/bukhari:3705) |
| 10 | `sleep-allahuakbar-34` | اللَّهُ أَكْبَرُ | 34 | [Sahih al-Bukhari 3705, Sahih Muslim 2727 — 34 times at bedtime](https://sunnah.com/bukhari:3705) |
| 11 | `sleep-rabb-as-samawat` | اللَّهُمَّ رَبَّ السَّمَوَاتِ وَرَبَّ الأَرْضِ … | 1 | [Sahih Muslim 2713 — on going to bed](https://sunnah.com/muslim:2713a) |
| 12 | `sleep-atamana` | الْحَمْدُ لِلَّهِ الَّذِي أَطْعَمَنَا وَسَقَانَا … | 1 | [Sahih Muslim 2715 — on going to bed](https://sunnah.com/muslim:2715) |
| 13 | `sleep-fatir-as-samawat` | اللَّهُمَّ فَاطِرَ السَّمَوَاتِ وَالأَرْضِ عَالِمَ … | 1 | [Abu Dawud 5067 (graded sahih by al-Albani) — morning, evening and on going to bed](https://sunnah.com/abudawud:5067) |
| 14 | `sleep-aslamtu` | اللَّهُمَّ أَسْلَمْتُ وَجْهِي إِلَيْكَ، وَفَوَّضْتُ … | 1 | [Sahih al-Bukhari 6311, Sahih Muslim 2710 — the last words before sleeping](https://sunnah.com/bukhari:6311) |

## Other texts in the app — Figma ١٤–١٧ (checked 2026-11-19)

Quoted in the designs and kept as worded there; each checked against its
source, and signed off by Mariam on 2026-11-20 once the two open gradings
below were confirmed (`etiquetteVerified` in
`lib/features/etiquette/data/etiquette.dart`; while false, the page shows the
design's "المصادر تُراجَع قبل النشر").

**Quran** (cut from api.alquran.cloud "quran-simple", to the first pause
mark; checked character for character in the code):

| Where | Text | Reference |
|---|---|---|
| Home reminder (the design's) | وَإِذَا سَأَلَكَ عِبَادِي عَنِّي فَإِنِّي قَرِيبٌ | Al-Baqarah 2:186 |
| Home reminder; etiquette page | وَقَالَ رَبُّكُمُ ادْعُونِي أَسْتَجِبْ لَكُمْ | Ghafir 40:60 |
| Home reminder | ادْعُوا رَبَّكُمْ تَضَرُّعًا وَخُفْيَةً | Al-A'raf 7:55 |
| Completion screen | رَبَّنَا تَقَبَّلْ مِنَّا ۖ إِنَّكَ أَنْتَ السَّمِيعُ الْعَلِيمُ | Al-Baqarah 2:127 |

**Hadith** (the design's wording is often a paraphrase; the source's words
are on the linked page):

| Where | As shown | Checked against | Grade |
|---|---|---|---|
| Completion; Home's week (mid-week line) | «أحبُّ الأعمال إلى الله أدومُها وإن قلّ» — متفق عليه | [Bukhari 6464](https://sunnah.com/bukhari:6464), [Muslim 783b](https://sunnah.com/muslim:783b) | Bukhari & Muslim |
| Completion (share line) | الدالّ على الخير كفاعله | [Tirmidhi 2670](https://sunnah.com/tirmidhi:2670) | Sahih (Darussalam) |
| Etiquette 1 | Praise, then salawat, then ask — الترمذي وأبو داود | [Tirmidhi 3477](https://sunnah.com/tirmidhi:3477), [Abu Dawud 1481](https://sunnah.com/abudawud:1481) | Tirmidhi: hasan sahih; al-Albani: sahih |
| Etiquette 2 | «ادعوا الله وأنتم موقنون بالإجابة» — الترمذي | [Tirmidhi 3479](https://sunnah.com/tirmidhi:3479) | al-Albani: hasan (Sahih al-Jami' 245, as-Sahiha 596). Darussalam / Zubair Ali Zai: da'if; at-Tirmidhi: gharib. Meets our bar through al-Albani — confirmed 2026-11-20 |
| Etiquette 3 | Don't say "if You will" — البخاري ومسلم | [Bukhari 6339](https://sunnah.com/bukhari:6339), [Muslim 2679a](https://sunnah.com/muslim:2679a) | Bukhari & Muslim |
| Etiquette 4 | «إن ربكم حييٌّ كريم…» — أبو داود والترمذي | [Abu Dawud 1488](https://sunnah.com/abudawud:1488), [Tirmidhi 3556](https://sunnah.com/tirmidhi:3556) | Abu Dawud: sahih (al-Albani); Tirmidhi's version da'if (Darussalam) |
| Etiquette 5 | He made dua three times — مسلم | [Muslim 1794a](https://sunnah.com/muslim:1794a) | Muslim |
| Etiquette 6 | «آمين، ولك بمثل» — مسلم | [Muslim 2732a, 2732b](https://sunnah.com/muslim:2732b) ("الملك الموكل به آمين ولك بمثل") | Muslim |
| Avoid 1 | «يُستجاب لأحدكم ما لم يَعجل…» — البخاري ومسلم | [Bukhari 6340](https://sunnah.com/bukhari:6340), [Muslim 2735a](https://sunnah.com/muslim:2735a) | Bukhari & Muslim |
| Avoid 2 | «لا يزال يُستجاب للعبد ما لم يدعُ بإثمٍ أو قطيعة رحم» — مسلم | [Muslim 2735c](https://sunnah.com/muslim:2735c) | Muslim |
| Avoid 3 | «لا تدعوا على أنفسكم…» — مسلم | Muslim 3009 ([dorar.net](https://dorar.net/h/sUk6RZaz); sunnah.com's page didn't load); also [Abu Dawud 1532](https://sunnah.com/abudawud:1532), adding "خدمكم" | Muslim; Abu Dawud sahih (al-Albani) |
| "دعاؤك لا يضيع" | «ما من مسلم يدعو بدعوة…» — مسند أحمد | Ahmad 11133 ([dorar.net](https://dorar.net/h/4qZM4VXn)) | al-Albani: hasan sahih (Sahih at-Targhib 1633), sahih (Sahih al-Adab al-Mufrad 547 — al-Bukhari's [al-Adab al-Mufrad 710](https://sunnah.com/adab:710)); al-Mundhiri: "with good chains" — confirmed 2026-11-20 |
| Last-third alert | ينزل ربنا… «من يدعوني فأستجيب له؟» | [Bukhari 1145](https://sunnah.com/bukhari:1145) | Bukhari |

The English renderings of all of these are ours.
