// server.js
const express = require('express');
const cors    = require('cors');
const pool    = require('./config_DB');

const app = express();
app.use(cors());
app.use(express.static('public'));

// Endpoint de puntos turísticos
app.get('/puntos', async (_, res) => {
  try {
    const result = await pool.query(`
      SELECT id, nombre, tipo, direccion, ciudad, horario_apertura,
             horario_cierre, precio_entrada,
             ST_AsGeoJSON(ubicacion) AS geom
      FROM lugares_turisticos;
    `);
    res.json({
      type: 'FeatureCollection',
      features: result.rows.map(r => ({
        type: 'Feature',
        geometry: JSON.parse(r.geom),
        properties: {
          id: r.id,
          nombre: r.nombre,
          tipo: r.tipo,
          direccion: r.direccion,
          ciudad: r.ciudad,
          horario_apertura: r.horario_apertura,
          horario_cierre: r.horario_cierre,
          precio_entrada: r.precio_entrada
        }
      }))
    });
  } catch (err) {
    console.error(err);
    res.status(500).send('Error en /puntos');
  }
});

// Endpoint de zonas turísticas
app.get('/zonas', async (_, res) => {
  try {
    const result = await pool.query(`
      SELECT id, nombre_zona, tipo_zona, descripcion,
             ST_AsGeoJSON(geom) AS geom
      FROM zonas_turisticas;
    `);
    res.json({
      type: 'FeatureCollection',
      features: result.rows.map(r => ({
        type: 'Feature',
        geometry: JSON.parse(r.geom),
        properties: {
          id: r.id,
          nombre_zona: r.nombre_zona,
          tipo_zona: r.tipo_zona,
          descripcion: r.descripcion
        }
      }))
    });
  } catch (err) {
    console.error(err);
    res.status(500).send('Error en /zonas');
  }
});

// Arranca el servidor
const PORT = 3000;
app.listen(PORT, () =>
  console.log(`Servidor arriba en http://localhost:${PORT}`)
);
