import Header from "../components/Header";
import Sidebar from "../components/Sidebar";

const Pemasok = () => {
    return (
        <>
            <main className="flex">
                <Sidebar />
                <div className="w-full flex flex-col">
                    <Header />
                    <div className="w-full flex justify-between p-10">
                        <h1 className="text-3xl font-bold">Pemasok</h1>
                        <button className="bg-green-500 text-white px-4 py-2 rounded">
                            Add
                        </button>
                    </div>
                    <div className="px-10">
                        <table class="min-w-full text-left text-sm font-light">
                            <thead class="border-b font-medium dark:border-neutral-500">
                                <tr>
                                    <th scope="col" class="px-6 py-4">
                                        ID Pemasok
                                    </th>
                                    <th scope="col" class="px-6 py-4">
                                        Nama Pemasok
                                    </th>
                                    <th scope="col" class="px-6 py-4">
                                        Alamat
                                    </th>
                                    <th scope="col" class="px-6 py-4">
                                        Nomor Telepon
                                    </th>
                                    <th scope="col" class="px-6 py-4">
                                        Email
                                    </th>
                                    <th scope="col" class="px-6 py-4">
                                        Aksi
                                    </th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </main>
        </>
    );
};

export default Pemasok;
