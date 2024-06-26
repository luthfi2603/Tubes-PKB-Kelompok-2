% Tugas Besar Praktikum Kecerdasan Buatan
% Kelompok 3
% Rifqi Jabrah Rhae (221402031)
% Clinton Christovel Simanullang (221402047)
% Muhammad Luthfi (221402050)
% Andy Septiawan Saragih (221402053)

% Sistem Klasifikasi Buku

/* Basis Pengetahuan */
inc(buku, fiksi).
inc(buku, nonfiksi).

inc(fiksi, novel).
inc(fiksi, komik).

inc(nonfiksi, biografi).
inc(nonfiksi, motivasi).
inc(nonfiksi, ensiklopedia).

inc(novel, romantis).
inc(novel, drama).
inc(novel, misteri).
inc(novel, fantasi).
inc(novel, komedi).
inc(novel, horror).

inc(romantis, dilan).
inc(romantis, milea).
inc(romantis, jingga_dan_senja).
inc(romantis, teluk_alaska).
inc(romantis, hujan).
inc(romantis, ayat_ayat_cinta).
inc(romantis, architecture_of_Love).
inc(romantis, perahu_kertas).
inc(romantis, ada_apa_dengan_cinta).

inc(drama, laskar_pelangi).
inc(drama, '5_CM').
inc(drama, negri_5_menara).

inc(misteri, newcomer).
inc(misteri, dua_dini_hari).
inc(misteri, the_davinci_code).
inc(misteri, the_devotion_of_mr_x).
inc(misteri, gone_girl).
inc(misteri, the_snowman).
inc(misteri, the_silence_of_the_lambs).
inc(misteri, pemburu_halimun).

inc(fantasi, harry_potter).
inc(fantasi, tujuh_kelana).
inc(fantasi, narnia).
inc(fantasi, fantastic_beast).
inc(fantasi, bumi).
inc(fantasi, aroma_karsa).
inc(fantasi, mata_di_tanah_melus).
inc(fantasi, percy_jackson).
inc(fantasi, the_lord_of_the_rings).

inc(komedi, kambing_jantan).
inc(komedi, ngenest).
inc(komedi, manusia_setengah_salmon).
inc(komedi, ubur_ubur_lembur).

inc(horror, holy_mother).
inc(horror, surat_dari_kematian).
inc(horror, pesta_bunuh_diri).

inc(komik, action).
inc(komik, mysteri).
inc(komik, fantasy).
inc(komik, romance).

inc(action, one_piece).
inc(action, hunter_x_hunter).
inc(action, solo_leveling).
inc(action, tower_of_god).
inc(action, noblesse).
inc(action, tokyo_revengers).
inc(action, naruto).
inc(action, dragon_ball).
inc(action, bleach).

inc(mysteri, detective_conan).
inc(mysteri, death_note).
inc(mysteri, monster).
inc(mysteri, '20th century boys').
inc(mysteri, hyouka).
inc(mysteri, gosick).
inc(mysteri, another).

inc(fantasy, attack_on_titan).
inc(fantasy, fairy_tail).
inc(fantasy, fullmetal_alchemist).
inc(fantasy, my_hero_academia).
inc(fantasy, the_seven_deadly_sins).
inc(fantasy, sousou_no_frieren).
inc(fantasy, doraemon).
inc(fantasy, sword_art_online).
inc(fantasy, no_game_no_life).

inc(romance, your_lie_in_april).
inc(romance, clannad).
inc(romance, anohana).
inc(romance, violet_evergarden).
inc(romance, erased).
inc(romance, orange).
inc(romance, a_silent_voice).
inc(romance, the_garden_of_words).

inc(biografi, kisah_buya_hamka).
inc(biografi, steve_jobs).
inc(biografi, biografi_gus_dur).
inc(biografi, gelap_terang_kartini).
inc(biografi, jack_ma).
inc(biografi, sirah_nabawiyah).
inc(biografi, queen_of_our_times).

inc(motivasi, filosofi_teras).
inc(motivasi, atomic_habits).
inc(motivasi, sebuah_seni_untuk_bersikap_bodo_amat).
inc(motivasi, sang_alkemis).
inc(motivasi, nanti_juga_sembuh_sendiri).
inc(motivasi, grit).
inc(motivasi, the_principles_of_power).
inc(motivasi, today_matters).
inc(motivasi, good_habits_bad_habits).

inc(ensiklopedia, ensiklopedia_indonesia).
inc(ensiklopedia, ensiklopedia_shalat).
inc(ensiklopedia, ensiklopedia_sejarah_dunia).

golongan(X, Y) :- inc(Y,X).
golongan(X, Y) :- inc(Y,Z), golongan(X,Z).

jenis(X) :- inc(X, _); inc(_,X).
tergolong(X) :- golongan(_, X).
judul_buku(X) :- jenis(X), not(tergolong(X)).

genre(X, Y) :- inc(X, Y), judul_buku(Y), inc(novel, X).
genre(X, Y) :- inc(X, Y), judul_buku(Y), inc(komik, X).

komik(X) :- inc(fiksi, komik), inc(komik,Y), inc(Y,X).

novel(X) :- inc(fiksi, novel), inc(novel,Y), inc(Y,X).

buku_fiksi(X) :- judul_buku(X), komik(X) ; novel(X).

buku_nonfiksi(X) :- judul_buku(X), not(buku_fiksi(X)).

golongan_buku(X, Y) :- buku_nonfiksi(Y) -> (inc(X, Y), judul_buku(Y)) ; inc(Y1, Y), inc(X, Y1).

cari_buku :- 
    repeat,
    write('Menu Pencarian Buku:'), nl,
    write('1. Cari buku berdasarkan judul'), nl,
    write('2. Cari buku berdasarkan genre'), nl,
    write('3. Cari buku berdasarkan jenis'), nl,
    write('4. Cari buku berdasarkan golongan'), nl,
    write('0. Keluar'), nl,
    write('Pilihan Anda: '), read(Pilihan), nl,
    (
        Pilihan = 1 -> cari_buku_judul;
        Pilihan = 2 -> cari_buku_genre;
        Pilihan = 3 -> cari_buku_jenis;
        Pilihan = 4 -> cari_buku_golongan;
        Pilihan = 0 -> !;
        write('Pilihan tidak valid.'), nl, nl, fail
    ).

cari_buku_judul :-
    write('Masukkan judul buku: '), 
    read(Judul), 
    nl, 
    (   
        judul_buku(Judul) -> (
            (buku_fiksi(Judul) -> write('Buku fiksi'), nl ; write('Buku non-fiksi'), nl),
            genre(Genre, Judul), golongan_buku(Jenis, Judul),
            (write('Judul Buku : '), 
                write(Judul), 
                nl,
                write('Genre : '), 
                write(Genre), 
                nl,
                write('Golongan : '),
                write(Jenis),
                nl
            );
            ((golongan_buku(Jenis, Judul),
                write('Judul Buku : '), 
                write(Judul), 
                nl,
                write('Golongan : '), 
                write(Jenis),
                nl
            ))
        ); 
        write('Buku tidak ditemukan.'), nl
    ).

cari_buku_genre :-
    write('Masukkan genre buku: '), read(Genre), nl,
    (
        (inc(novel, Genre); inc(komik, Genre)) ->
        (
            write('Buku dalam genre '), write(Genre), write(':'), nl,
            findall(Judul, (judul_buku(Judul), genre(Genre, Judul)), DaftarBuku),
            write('Buku-buku dalam genre ini: '), write(DaftarBuku), nl
        );
        (
            write('Genre buku tidak ditemukan.'), nl
        )
    ).

cari_buku_jenis :-
    write('Masukkan jenis buku (fiksi/nonfiksi): '), read(Jenis), nl,
    (
        Jenis = fiksi ->
        (
            write('Buku fiksi yang tersedia:'), nl,
            findall(Judul, (judul_buku(Judul), buku_fiksi(Judul)), DaftarBuku),
            write('Buku-buku fiksi yang tersedia: '), write(DaftarBuku), nl
        );
        Jenis = nonfiksi ->
        (
            write('Buku non-fiksi yang tersedia:'), nl,
            findall(Judul, (judul_buku(Judul), buku_nonfiksi(Judul)), DaftarBuku),
            write('Buku-buku non-fiksi yang tersedia: '), write(DaftarBuku), nl
        );
        write('Jenis buku tidak valid.'), nl
    ).

cari_buku_golongan :-
    write('Masukkan golongan buku (novel, komik, biografi, motivasi, ensiklopedia): '), read(Golongan), nl,
    (
        Golongan = novel ->
        (
            findall(Judul, (judul_buku(Judul), novel(Judul)), DaftarBuku),
            write('Buku dalam golongan '), write(Golongan), write(': '), write(DaftarBuku), nl
        );
        Golongan = komik ->
        (
            findall(Judul, (judul_buku(Judul), komik(Judul)), DaftarBuku),
            write('Buku dalam golongan '), write(Golongan), write(': '), write(DaftarBuku), nl
        );
        Golongan = biografi ->
        (
            findall(Judul, (judul_buku(Judul), inc(biografi, Judul)), DaftarBuku),
            write('Buku dalam golongan '), write(Golongan), write(': '), write(DaftarBuku), nl
        );
        Golongan = motivasi ->
        (
            findall(Judul, (judul_buku(Judul), inc(motivasi, Judul)), DaftarBuku),
            write('Buku dalam golongan '), write(Golongan), write(': '), write(DaftarBuku), nl
        );
        Golongan = ensiklopedia ->
        (
            findall(Judul, (judul_buku(Judul), inc(ensiklopedia, Judul)), DaftarBuku),
            write('Buku dalam golongan '), write(Golongan), write(': '), write(DaftarBuku), nl
        );
        write('Golongan tidak ditemukan.'), nl
    ).

main :-
    cari_buku,
    nl,
    repeat,
    write('Apakah Anda ingin melanjutkan pencarian buku? (y/n) '), read(Jawaban), nl, (
        Jawaban = y -> main ;
        Jawaban = n -> ! ; Jawaban \= y, Jawaban \= n -> write('Masukan tidak valid.'), nl, nl, fail
    ).