# Shawn P. Serbin

# Create surface model
python3 /isofit/utils/surfmodel.py configs/ang20171108t184227_surface.json

# Run experiments 
python3 /isofit/isofit/isofit.py --level DEBUG configs/ang20171108t173546_horse-libradtran.json 
#python3 /isofit/isofit/isofit.py --level DEBUG configs/ang20171108t184227_beckmanlawn-libradtran.json 
