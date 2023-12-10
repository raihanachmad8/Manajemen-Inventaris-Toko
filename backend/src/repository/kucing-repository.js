import { db } from "../../database/config/db.js";
import { logger } from "../app/logging.js";
import { ResponseError } from "../errors/response-error.js";

const getAll = async () => {
    try {
        const result = await db("Kucing")
            .select(
                "Kucing.ID_Kucing",
                "Kucing.Nama_Kucing",
                "Kucing.Foto",
                "Kucing.Umur",
                "Kucing.Jenis_Kelamin",
                "Kucing.Tanggal_Masuk",
                "Kucing.Biaya",
                "Kucing.Status",
                "Kucing.Keterangan",
                "Jenis.ID_Jenis",
                "Jenis.Jenis_Kucing"
            )
            .join("Jenis", "Kucing.ID_Jenis", "Jenis.ID_Jenis");
        return await result.map((result) => formattedResult(result))
    } catch (error) {
        logger.error("Error while getting all Kucing", error);
        throw new ResponseError(500, "Internal Server Error");
    }
};

const seacrh = async (params) => {
    try {
        const result = await db("Kucing")
            .whereLike(params.Nama_Kucing)
            .orWhereLike(params.Jenis_Kucing)
            .orWhereLike(params.Umur)
            .orWhereLike(params.Jenis_Kelamin)
            .orWhereLike(params.Biaya)
            .orWhereLike(params.Status)
            .select("*");
        return result;
    } catch (error) {
        logger.error("Error while searching Kucing", error);
        throw new ResponseError(500, "Internal Server Error");
    }
};

const findById = async (id) => {
    try {
        const result = await db("Kucing")
        .select(
            "Kucing.ID_Kucing",
            "Kucing.Nama_Kucing",
            "Kucing.Foto",
            "Kucing.Umur",
            "Kucing.Jenis_Kelamin",
            "Kucing.Tanggal_Masuk",
            "Kucing.Biaya",
            "Kucing.Status",
            "Kucing.Keterangan",
            "Jenis.ID_Jenis",
            "Jenis.Jenis_Kucing"
        )
        .join("Jenis", "Kucing.ID_Jenis", "Jenis.ID_Jenis")
        .where({ ID_Kucing: id });
        return await formattedResult(result[0])
    } catch (error) {
        logger.error("Error while finding Kucing by id: ", error);
        throw new ResponseError(500, "Internal Server Error");
    }
};

const create = async (kucing) => {
    try {
        const id = await incrementId("Kucing", "ID_Kucing", "K");
        logger.info(id);
        await db.raw(`
        EXEC TambahKucing 
            @ID_Kucing = :ID_Kucing,
            @ID_Jenis = :ID_Jenis,
            @Nama_Kucing = :Nama_Kucing,
            @Foto = :Foto,
            @Umur = :Umur,
            @Jenis_Kelamin = :Jenis_Kelamin,
            @Tanggal_Masuk = :Tanggal_Masuk,
            @Biaya = :Biaya,
            @Status = :Status,
            @Keterangan = :Keterangan;
        `, {
            ID_Kucing: id,
            ID_Jenis: kucing.ID_Jenis,
            Nama_Kucing: kucing.Nama_Kucing,
            Foto: kucing.Foto,
            Umur: kucing.Umur,
            Jenis_Kelamin: kucing.Jenis_Kelamin,
            Tanggal_Masuk: kucing.Tanggal_Masuk,
            Biaya: kucing.Biaya,
            Status: kucing.Status,
            Keterangan: kucing.Keterangan,
        })
        return await db("Kucing").select("*").where({ ID_Kucing: id });
    } catch (error) {
        logger.error("Error while creating kucing:", error);
        throw new ResponseError(500, "Internal Server Error");
    }
};

const update = async (kucing) => {
    try {
        await db.raw(`
        EXEC UpdateKucing 
            @ID_Kucing = :ID_Kucing,
            @ID_Jenis = :ID_Jenis,
            @Nama_Kucing = :Nama_Kucing,
            @Foto = :Foto,
            @Umur = :Umur,
            @Jenis_Kelamin = :Jenis_Kelamin,
            @Tanggal_Masuk = :Tanggal_Masuk,
            @Biaya = :Biaya,
            @Status = :Status,
            @Keterangan = :Keterangan;
        `, {
            ID_Kucing: kucing.ID_Kucing,
            ID_Jenis: kucing.ID_Jenis,
            Nama_Kucing: kucing.Nama_Kucing,
            Foto: kucing.Foto,
            Umur: kucing.Umur,
            Jenis_Kelamin: kucing.Jenis_Kelamin,
            Tanggal_Masuk: kucing.Tanggal_Masuk,
            Biaya: kucing.Biaya,
            Status: kucing.Status,
            Keterangan: kucing.Keterangan,
        })
        return db("Kucing").select("*").where({ ID_Kucing: kucing.ID_Kucing });
    } catch (error) {
        logger.error("Error while updating kucing:", error);
        throw new ResponseError(500, "Internal Server Error");
    }
};

const remove = async (id) => {
    try {
        const result = await db.raw(`
        EXEC HapusKucing @ID_Kucing = :ID_Kucing;`, { ID_Kucing: id })
        return (await db("Kucing").where({ ID_Kucing: id }) == false);
    } catch (error) {
        logger.error("Error while deleting kucing", error);
        throw new ResponseError(500, "Internal Server Error");
    }
};

const incrementId = async (table, column, prefix = '') => {
    try {
        const result = await db
        .raw(`
        SELECT TOP 1 ${column}
        FROM ${table}
        ORDER BY CAST(SUBSTRING(${column}, ${prefix.length +1}, LEN(${column})) AS INT) DESC
        `)
        const newId = result[0][column].substring(prefix.length)
        return prefix + (parseInt(newId) + 1)
    } catch (error) {
        logger.error('Error while getting last id kucing', error)
        throw new ResponseError(500, "Internal Server Error")
    }
}

const formattedResult = (result) => {
    return {
        ID_Kucing: result.ID_Kucing,
        Jenis_Kucing: {
        ID_Jenis: result.ID_Jenis,
        Jenis_Kucing: result.Jenis_Kucing,
        },
        Nama_Kucing: result.Nama_Kucing,
        Foto: result.Foto,
        Umur: result.Umur,
        Jenis_Kelamin: result.Jenis_Kelamin,
        Tanggal_Masuk: result.Tanggal_Masuk,
        Biaya: result.Biaya,
        Status: result.Status,
        Keterangan: result.Keterangan,
    };
}

export const kucingRepository = {
    getAll,
    seacrh,
    findById,
    create,
    update,
    remove,
};
