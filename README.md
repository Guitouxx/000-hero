# PlayGL Dotted Hero (in fragmenr shader)

![Demo Screenshot](https://github.com/Guitouxx/000-hero/blob/main/static/screenshot.png?raw=true)

This repo includes a fragment shader demo from the homepage of [playgl.xyz](https://playgl.xyz).


Basically, it's a full screen quad that with a THREE.RawShaderMaterial. Please play with the available uniforms to customize the effect. I didn't write the code for mobile adjustement but you can figure it out with the source code how to move the letters at a different place. 

All the glsl magic happens in the `src/routes/glsl` folder. 


All prototypes that comes from playgl experiments will be shipped with:
- Threejs  
- Sveltekit  
- Tailwindcss

## Dev


To run:

```sh
# clone repo
git clone https://github.com/Guitouxx/000-hero.git

# install deps
yarn

# run local host
yarn dev
```

Now open `localhost:3000` to test. Use `yarn run build` to build everything.

## Thanks

Thank you for the help they shared on github, x or shadertoy

[Daniel Velasquez](https://x.com/anemolito)  
[Inigo Quilez](https://x.com/iquilezles) 


## License

MIT, see [LICENSE](https://github.com/Guitouxx/000-hero/blob/main/LICENSE) for details.
