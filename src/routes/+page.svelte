<script lang="ts">
	import 'css/main.css';
	import { onMount } from 'svelte';
	import { BufferGeometry, Clock, Color, Float32BufferAttribute, GLSL3, Mesh, OrthographicCamera, RawShaderMaterial, Scene, Vector2, WebGLRenderer } from 'three';
	import fragmentShader from "./glsl/fragment.glsl";
	import vertexShader from "./glsl/vertex.glsl";

  //----- Vars

  let clock : Clock;
  let renderer : WebGLRenderer;
  let scene : Scene;
  let camera : OrthographicCamera;
  let mesh : Mesh;
  let wrapperEl : HTMLElement;
  let mouse : Vector2 = new Vector2();

  //----- Methods

  const initThree = () => {
    renderer = new WebGLRenderer({
      alpha: false,
      antialias: true
    });
    renderer.setPixelRatio(Math.min(window.devicePixelRatio, 1.5));
    wrapperEl.appendChild(renderer.domElement);
  }

  const initScene = () => {
    scene = new Scene();
    camera = new OrthographicCamera(1, 1, 1, 1, 1, 1000);

    // full quad geometry
    const geometry = new BufferGeometry();
		geometry.setAttribute('position', new Float32BufferAttribute([-1, 3, 0, -1, -1, 0, 3, -1, 0], 3));
		geometry.setAttribute('uv', new Float32BufferAttribute([0, 2, 0, 0, 2, 0], 2));

    // one mesh with one rawshader material
    mesh = new Mesh(
			geometry,

			new RawShaderMaterial({
				vertexShader,
				glslVersion: GLSL3,
				fragmentShader,
				uniforms: {
          uTime: { value: 0},
          uMouse: { value : new Vector2() },
          uResolution: { value : new Vector2() },
          uTotalCells: { value: 60 },
          uCellDefaultColor: { value: new Color(0.3, 0.3, 0.3) },
          uCellDefaultRadius: { value: 0.2 },
          uCellHighlightRadius: { value: 0.5 },
          uMouseRadius: { value: 0.3 },
        }
			})
		);

		scene.add(mesh);

    //start a threejs clock
    clock = new Clock(true);
  }

  const initEvents = () => {
    window.addEventListener("mousemove", onMove);
  }

  const render = () => {
    requestAnimationFrame(render);

    //update uniforms
    const material : RawShaderMaterial = mesh.material as RawShaderMaterial;
    if(material) {
      material.uniforms.uTime.value = clock.getElapsedTime();
      material.uniforms.uMouse.value.copy(mouse);
    }

    renderer.render(scene, camera);
  }

  const resize = () => {
    const material : RawShaderMaterial = mesh.material as RawShaderMaterial;
    if(material) {
      material.uniforms.uResolution.value.set(window.innerWidth, window.innerHeight);
    }
    renderer.setSize(window.innerWidth, window.innerHeight);
  }

  //----- Event Handlers

  const onMove = (e : MouseEvent) => {
    mouse.set(
      (e.clientX / window.innerWidth) * 2 - 1,
      -(e.clientY / window.innerHeight) * 2 + 1
    );
  }

  //----- Lifecycle
  
  onMount( () => {
    initThree();
    initScene();
    initEvents();
    resize();
    render();
  });

</script>

<svelte:window on:resize={resize} />

<div bind:this={wrapperEl} id="threejs-wrapper" class="fixed w-full h-full left-0 top-0"></div>
