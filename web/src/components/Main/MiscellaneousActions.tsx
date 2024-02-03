import { AlertTriangle, ArrowLeft, ArrowRight, Power } from "lucide-react";
import React from "react";
import { VehicleData } from "../../types/VehicleData";
import { fetchNui } from "../../utils/fetchNui";
import IconButton from "./IconButton";

interface Props {
  vehicleData: VehicleData | undefined;
}

const MiscellaneousActions: React.FC<Props> = React.memo(({ vehicleData }) => {
  return (
    <>
      <div className="bg-gradient-to-r from-[#222530] to-[#1d212b] w-full h-[10dvh] rounded-[2px]">
        <div className="flex flex-col gap-2 justify-center items-center font-main">
          <p className="bg-gradient-to-r px-10 py-1 mt-2 rounded-[2px] from-[#2f323d] via-[#3d3f49] to-[#292c37] text-[#2fffd2] font-bold">
            Miscellaneous
          </p>
          <div className="flex w-full justify-center items-center gap-2 text-white">
            <IconButton
              onClick={() => {
                fetchNui("vehmenu:toggleoption", {
                  option: "engine",
                });
              }}
              Icon={Power}
              disabled={!vehicleData?.isDriver}
              isActive={false}
            />
            <IconButton
              onClick={() => {
                fetchNui("vehmenu:toggleoption", {
                  option: "leftblinker",
                });
              }}
              Icon={ArrowLeft}
              disabled={!vehicleData?.isDriver}
              isActive={false}
            />
            <IconButton
              onClick={() => {
                fetchNui("vehmenu:toggleoption", {
                  option: "alert",
                });
              }}
              Icon={AlertTriangle}
              disabled={!vehicleData?.isDriver}
              isActive={false}
            />
            <IconButton
              onClick={() => {
                fetchNui("vehmenu:toggleoption", {
                  option: "rightblinker",
                });
              }}
              Icon={ArrowRight}
              disabled={!vehicleData?.isDriver}
              isActive={false}
            />
          </div>
        </div>
      </div>
    </>
  );
});

export default MiscellaneousActions;
