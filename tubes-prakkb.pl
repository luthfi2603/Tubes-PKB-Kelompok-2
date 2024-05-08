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

inc(biografi, kisah_buya_hamka).
inc(biografi, steve_jobs).
inc(biografi, bografi_gus_dur).
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

buku_fiksi(X) :- judul_buku(X), genre(Y, X), inc(novel, Y).

buku_nonfiksi(X) :- judul_buku(X), not(buku_fiksi(X)).

cari_buku(X) :- once(judul_buku(X) -> ((buku_fiksi(X)) -> (J = fiksi), genre(G, X), golongan(G, T)
                                ,write("Judul Buku : "), write(X), nl
                                ,write("Jenis : "), write(J), nl                                
                                ,write("Tipe : "), write(T), nl
                                ,write("Genre : "), write(G), nl
                                ;
                                (J = non_fiksi), golongan(X, T)
                                ,write("Judul Buku : "), write(X), nl
                                ,write("Jenis : "), write(J), nl                                
                                ,write("Tipe : "), write(T), nl)
                                ;
                                write("Buku Belum Terdaftar")), !. 
                                
