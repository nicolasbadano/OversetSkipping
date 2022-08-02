# OversetSkipping

Overset gridding refers to the use of multiple disconnected grids to discretize the flow domain, which can overlap each other. For moving objects, you would typically have a fixed base grid, discretizing the entire flow domain, and a second grid discretizing the zone around the object in greater detail, which would move following the object itself. With that setup you can always have great discretization where you need it, regardless of how much the object moves.

OpenCFD's version of OpenFOAM includes a wide array of Overset-Grid-capable solvers.

These repository holds an example of this technique, applied to the universally-loved passtime of stone skipping. I tried to replicate the experimental setup published by Tsai et al. (https://doi.org/10.1016/j.expthermflu..., using a non-spinning 30mm by 5mm aluminum disk, thrown toward water at 5 m/s, but I might have gotten some of details wrong (no 2nd skip 😔).

The case uses the overInterDyMFoam multiphase solver. The fixed mesh has a 5mm horizontal and 2.5mm vertical discretization (which is too coarse to solve splashing accurately); meanwhile, the mesh around the disk has a 1mm cell size, with further refinement near the surface. The disk motion is solved with six degrees of freedom, without any constraint.

As always, nothing is perfect, and the overset grid technique has some drawbacks.

The main one I found is that the mesh-to-mesh geometric mapping, which needs to be performed every time the object moves (every timestep!), is a bit slow, and accounted for ~ 50% of the simulation time in this case. Without looking into the implementation in depth, I have the impression that it is done from scratch every time, which is probably unnecessary (displacements are small on a single time step), so maybe this could be optimized in the future.

Another commonly pointed limitation is that this technique is not rigorously mass-conserving.

## Getting Started

* Run the `prepare.sh` to generate the mesh and setup the simulation.
* Then run the case with `overInterDyMFoam`

## Results

[![Watch the video](https://img.youtube.com/vi/ohZPMKvA9Lw/default.jpg)](https://youtu.be/ohZPMKvA9Lw)

## License

This project is licensed under the MIT License - see the LICENSE.md file for details

## Author

Nicolás Diego Badano (https://www.linkedin.com/in/nicolas-diego-badano/)
