/* jshint esversion: 6 */
import commonjs from '@rollup/plugin-commonjs';
import dts from 'rollup-plugin-dts';
import external from 'rollup-plugin-peer-deps-external';
import postcss from 'rollup-plugin-postcss';
import resolve from '@rollup/plugin-node-resolve';
import typescript from '@rollup/plugin-typescript';
import { terser } from 'rollup-plugin-terser';
import packageJson from './package.json';

export default [
  {
    input: 'src/index.ts',
    output: [
      {
        file: packageJson.main,
        format: 'cjs',
        sourcemap: true,
        name: 'pyxis-react',
      },
      {
        file: packageJson.module,
        format: 'esm',
        sourcemap: true,
      },
    ],
    external: [/src\/stories.*/],
    plugins: [
      external(),
      resolve(),
      commonjs(),
      typescript({ tsconfig: './tsconfig.build.json' }),
      terser(),
      postcss(),
    ],
  },
  {
    input: 'dist/esm/types/index.d.ts',
    output: [
      {
        file: 'dist/index.d.ts',
        format: 'esm',
      },
    ],
    external: [/\.(s)css$/],
    plugins: [dts()],
  },
];
