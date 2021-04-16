# Ceph : Introduction 

<center>
    <img src="https://i0.wp.com/ceph.io/wp-content/uploads/2016/07/Ceph_Logo_Stacked_RGB_120411_fa.png" alt="Ceph" title="Ceph Logo" width="200" />
</center>

pada kesempatan kali ini kita akan membahas tentang Ceph, Nah kita mulai dengan perkenalan tentang ceph terlebih dahulu, pembahasan selanjutnya kita lanjut melakukan installasi dan integrasi ceph pada openstack.

# Sejarah Ceph

Ceph dibuat dan diciptakan oleh Sage Weil sebagai bagian dari disertasi doktoralnya di Universitas California, Santa Cruz (UCSC). Tujuan asli dari proyek Ceph adalah membangun sistem file yang sangat scalable, highly available file system, dimana dapat dengan cepat berevolusi menjadi sistem penyimpanan terdistribusi generik yang dibangun pada penyimpanan objek tingkat rendah, Pada bulan April 2014, Redhat membeli inktank, dan ceph dikembangkan secara in-house oleh Redhat. 

# Perkenalan Ceph

Ceph (diucapkan /ˈsɛf/ atau /ˈkɛf/ ) adalah open-source software storage platform yang berbasis penyimpanan objek pada suatu cluster komputer. Ceph menyediakan antarmuka penyimpanan dengan level object, block, dan file. Tujuan utama Ceph adalah menyediakan penyimpanan terdistribusi tanpa satu titik kegagalan, dapat ditingkatkan hingga skala exabyte, dan tersedia secara bebas.

Ceph mereplikasi data dan membuatnya fault tolerance. menggunakan perangkat keras komoditas dan tidak memerlukan dukungan perangkat keras khusus.

Cepth storage cluster menggunakan algoritma CRUSH (Controlled Replication Under Scalable Hashing) yang memastikan bahwa data terdistribusi ke seluruh anggota cluster dan semua cluster node dapat menyediakan data tanpa ada bottleneck.

Ceph block storage dapat dijadikan virtual disk pada Linux maupun virtual machine. Teknologi RADOS yang dimiliki Ceph memampukan Ceph melakukan snapshot dan replikasi.

Ceph object storage dapat diakses melalui Amazon S3 (Simple StorageService) dan OpenStack Swift REST (Representational State Transfer).

## Arsitektur Ceph

Ceph terdiri dari beberapa part yang berbeda. RADOS (also known as Ceph Object Store or Ceph Storage Cluster) merupakan pondasi dari Ceph.  RADOS merupakan the core set of storage software yang menyimpan user data. Akronim dari RADOS (Reliable Autonomic Distributed Object Storage).

<center>
    <img src="https://i-3.co.id/wp-content/uploads/2018/05/2-2.png" alt="Ceph" title="Ceph Architecture" width="500" />
</center>

## Komponen Rados

Fungsi dasar dan utama dari RADOS disediakan oleh kedua Ceph’s server daemons :

- OSDs: Object storage daemons.
- MONs: Monitoring servers.  

<center>
    <img src="https://misskecupbung.files.wordpress.com/2018/08/asset-v1_citycloudcc212201808typeassetblockimages_ceph-introduction-22.png" alt="Ceph" title="Ceph Rados" width="500" />
</center>

###### Referensi

Wikipedia Ceph : [Links](https://en.wikipedia.org/wiki/Ceph_(software)) 

Ceph Documentation : [Links](https://docs.ceph.com) 

```
Jika kamu tidak tahan dengan lelahnya belajar maka kamu harus tahan dengan perihnya kebodohan.
```
