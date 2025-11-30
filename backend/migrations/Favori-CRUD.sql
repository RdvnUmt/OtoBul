
use Bil372Proje;

-- CRUD for favourites
-- Create
INSERT INTO Favori (ilan_id,kullanici_id,olusturulma_tarihi) 
VALUES (2,1,NOW());

-- Read
SELECT * FROM favori
WHERE favori.kullanici_id = 1;

-- Update
-- Gerek duyulmayacak ya sil ya ekle


-- Delete
DELETE FROM favori 
WHERE favori.ilan_id = 2;



