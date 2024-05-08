% Tugas Besar Praktikum Kecerdasan Buatan
% Kelompok 3
% Rifqi Jabrah Rhae (221402031)
% Clinton Christovel Simanullang (221402047)
% Muhammad Luthfi (221402050)
% Andy Septiawan Saragih (221402053)
% Natal Zaro Zega (221402012)

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
inc(romantis, dilan).
inc(drama, laskar_pelangi).
inc(misteri, newcomer).
inc(fantasi, harry_potter).
inc(biografi, kisah_buya_hamka).
inc(motivasi, filosofi_teras).
inc(ensiklopedia, ensiklopedia_indonesia).

golongan(X, Y) :- inc(Y, X).
golongan(X, Y) :- inc(Y, Z), golongan(X, Z).

jenis(X) :- inc(X, _); inc(_, X).
tergolong(X) :- golongan(_, X).
judul_buku(X) :- jenis(X), not(tergolong(X)).

genre(X, Y) :- inc(X, Y), judul_buku(Y), inc(novel, X).

buku_fiksi(X) :- judul_buku(X), genre(Y, X), inc(novel, Y).

buku_nonfiksi(X) :- judul_buku(X), not(buku_fiksi(X)).